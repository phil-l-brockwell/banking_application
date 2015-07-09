require 'rufus-scheduler'
require 'timecop'
require 'controllers/controller_item_store'
require 'controllers/accounts_controller'

describe 'AccountsController' do
  let(:accounts_ctrl) { AccountsController.instance }

  def create_holder_and_return_id
    message = accounts_ctrl.holders.create('Robert Pulson')
    message.new_holder_id
  end

  def open_account_and_return_id(type = :Savings)
    holder_id = create_holder_and_return_id
    message = accounts_ctrl.open(type, with: holder_id)
    message.new_account_id
  end

  context 'when opening an account' do
    it 'returns a message with the new accounts id' do
      id = accounts_ctrl.id
      expect(open_account_and_return_id).to eq(id)
    end

    it 'increments the account id' do
      expect { open_account_and_return_id }
        .to change { accounts_ctrl.id }.by(1)
    end

    it 'gives the new account the correct account id' do
      id = open_account_and_return_id
      expect(accounts_ctrl.store[id].id).to eq(id)
    end

    it 'adds the new account to the accounts hash' do
      id = open_account_and_return_id
      expect(accounts_ctrl.store[id].main_holder.class).to eq(Holder)
      expect(accounts_ctrl.store[id]).to respond_to(:balance)
      expect(accounts_ctrl.store[id].type).to eq(:Savings)
    end

    it 'can open different account types' do
      id = open_account_and_return_id(:Current)
      expect(accounts_ctrl.store[id].type).to eq(:Current)
    end

    it 'knows if a holder exists' do
      expect(accounts_ctrl.holders.exist?(67)).not_to eq(true)
    end

    it 'schedules new interest payments' do
      id = open_account_and_return_id
      Timecop.scale(100_000_00)
      expect(accounts_ctrl.store[id]).to receive(:deposit)
      sleep(4)
    end
  end

  context 'when adding a holder to an existing account' do
    it 'the holder is added' do
      id = open_account_and_return_id
      new_holder_id = create_holder_and_return_id
      expect(accounts_ctrl.store[id]).to receive(:add_holder).once
        .with(accounts_ctrl.holders.store[new_holder_id])
      expect(accounts_ctrl.add_holder(new_holder_id, to: id).class)
        .to eq(AddHolderSuccessMessage)
    end

    it 'returns a holder exists message if the holder is the main holder' do
      new_holder_id = create_holder_and_return_id
      message = accounts_ctrl.open(:Current, with: new_holder_id)
      account_id = message.new_account_id
      expect(accounts_ctrl.add_holder(new_holder_id, to: account_id)
        .class).to eq(HolderOnAccountMessage)
    end

    it 'cannot add the same holder to an account twice' do
      new_holder_id = create_holder_and_return_id
      id = open_account_and_return_id
      accounts_ctrl.add_holder(new_holder_id, to: id)
      expect(accounts_ctrl.add_holder(new_holder_id, to: id).class)
        .to eq(HolderOnAccountMessage)
    end
  end

  context 'when depositing' do
    it 'can make a deposit' do
      id = open_account_and_return_id
      expect(accounts_ctrl.store[id]).to receive(:deposit).with(50.00)
      accounts_ctrl.deposit(50.00, into: id)
    end
  end

  context 'when withdrawing' do
    it 'can make a withdrawal' do
      id = open_account_and_return_id
      accounts_ctrl.deposit(50.00, into: id)
      expect(accounts_ctrl.store[id]).to receive(:withdraw).with(50.00)
      accounts_ctrl.withdraw(50.00, from: id)
    end

    it 'returns an error if a withdrawal is more than the account limit' do
      id = open_account_and_return_id
      accounts_ctrl.deposit 1000, into: id
      message = accounts_ctrl.withdraw 501, from: id
      expect(message.class).to eq(OverLimitMessage)
    end

    it 'can schedule a limit to be reset when a withdrawal is made' do
      id = open_account_and_return_id
      accounts_ctrl.deposit(50.00, into: id)
      accounts_ctrl.withdraw(50.00, from: id)
      Timecop.scale(100_000)
      expect(accounts_ctrl.store[id]).to receive(:reset_limit)
      sleep(1)
    end

    it 'does not schedule a limit reset if one is already scheduled' do
      id = open_account_and_return_id
      accounts_ctrl.deposit(50.00, into: id)
      expect(accounts_ctrl.task_manager).to receive(:in).once
      2.times { accounts_ctrl.withdraw(10.00, from: id) }
    end
  end

  context 'when making a transfer' do
    it 'can make a transfer between two accounts' do
      id = open_account_and_return_id
      accounts_ctrl.deposit(10.00, into: id)
      id_2 = open_account_and_return_id
      expect(accounts_ctrl.store[id]).to receive(:withdraw).with(10.00)
      expect(accounts_ctrl.store[id_2]).to receive(:deposit).with(10.00)
      accounts_ctrl.transfer(10.00, from: id, to: id_2)
    end

    it 'returns an error if the donar account has insufficient funds' do
      id = open_account_and_return_id
      id_2 = open_account_and_return_id
      message = accounts_ctrl.transfer(10.00, from: id, to: id_2)
      expect(message.class).to eq(InsufficientFundsMessage)
    end
  end

  context 'when transacting' do
    it 'knows if it contains an account in its store' do
      expect(accounts_ctrl.exist?(57)).not_to eq(true)
    end

    it 'can give the balance of an account' do
      id = open_account_and_return_id
      message = accounts_ctrl.get_balance_of(id)
      expect(message.balance).to eq(0.00)
    end

    it 'can reset the limit on an account' do
      id = open_account_and_return_id
      expect(accounts_ctrl.store[id]).to receive(:reset_limit)
      accounts_ctrl.reset_limit_on(accounts_ctrl.store[id])
    end

    it 'can return all transactions of a given account' do
      id = open_account_and_return_id
      transaction = double :transaction, type: :deposit, amount: 50.00, date: '1/1/01'
      accounts_ctrl.store[id].add_transaction(transaction)
      expect(accounts_ctrl.get_transactions_of(id).transactions)
        .to eq([transaction])
    end

    it 'can return all accounts for a given holder' do
      holder_id = create_holder_and_return_id
      second_holder_id = create_holder_and_return_id
      message = accounts_ctrl.open(:Savings, with: holder_id)
      id = message.new_account_id
      accounts_ctrl.open(:Savings, with: second_holder_id)
      message = accounts_ctrl.open(:Current, with: holder_id)
      id_3 = message.new_account_id
      expect(accounts_ctrl.get_accounts_of(holder_id).accounts)
        .to eq([accounts_ctrl.store[id], accounts_ctrl.store[id_3]])
    end
  end
end