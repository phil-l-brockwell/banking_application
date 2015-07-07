require 'rufus-scheduler'
require 'timecop'
require 'controller'

describe 'Controller' do
  let(:test_controller) { Controller.new }

  def create_holder_and_return_id
    message = test_controller.create_holder('Robert Pulson')
    message.new_holder_id
  end

  def open_account_and_return_id(type = :Savings)
    holder_id = create_holder_and_return_id
    message = test_controller.open_account(type, with: holder_id)
    message.new_account_id
  end

  context 'when initialised' do
    it 'has a hash of accounts' do
      expect(test_controller).to respond_to(:accounts)
    end

    it 'has a hash of holders' do
      expect(test_controller).to respond_to(:holders)
    end

    it 'has a current account id' do
      expect(test_controller.account_id).to eq(0)
    end

    it 'has a current holder id' do
      expect(test_controller.holder_id).to eq(0)
    end

    it 'has a task manager' do
      expect(test_controller).to respond_to(:task_manager)
    end
  end

  context 'when creating a holder' do
    it 'increments the holder number' do
      expect { create_holder_and_return_id }
        .to change { test_controller.holder_id }.by(1)
    end

    it 'returns a message with the new holders id' do
      id = test_controller.holder_id
      new_holder_id = create_holder_and_return_id
      expect(new_holder_id).to eq(id)
    end

    it 'gives the new holder the correct holder id' do
      id = create_holder_and_return_id
      expect(test_controller.holders[id].id).to eq(id)
    end

    it 'adds the new holder to the holders hash' do
      id = create_holder_and_return_id
      expect(test_controller.holders[id].name).to eq('Robert Pulson')
    end
  end

  context 'when opening an account' do
    it 'returns a message with the new accounts id' do
      id = test_controller.account_id
      expect(open_account_and_return_id).to eq(id)
    end

    it 'increments the account id' do
      expect { open_account_and_return_id }
        .to change { test_controller.account_id }.by(1)
    end

    it 'gives the new account the correct account id' do
      id = open_account_and_return_id
      expect(test_controller.accounts[id].id).to eq(id)
    end

    it 'adds the new account to the accounts hash' do
      id = open_account_and_return_id
      expect(test_controller.accounts[id].main_holder.class).to eq(Holder)
      expect(test_controller.accounts[id]).to respond_to(:balance)
      expect(test_controller.accounts[id].type).to eq(:Savings)
    end

    it 'can open different account types' do
      id = open_account_and_return_id(:Current)
      expect(test_controller.accounts[id].type).to eq(:Current)
    end

    it 'returns an error message if an invalid holder number is entered' do
      message = test_controller.open_account(:Current, with: 57)
      expect(message.class).to eq(InvalidHolderMessage)
    end

    it 'schedules new interest payments' do
      id = open_account_and_return_id
      first_time = Time.now
      Timecop.scale(100_000_00)
      expect(test_controller.accounts[id]).to receive(:add_interest)
      sleep(4)
      second_time = Time.now
      expect(second_time.year - first_time.year).to eq(1)
    end
  end

  context 'when adding a holder to an existing account' do
    it 'the holder is added' do
      id = open_account_and_return_id
      new_holder_id = create_holder_and_return_id
      expect(test_controller.accounts[id]).to receive(:add_holder).once
        .with(test_controller.holders[new_holder_id])
      expect(test_controller.add_holder(new_holder_id, to_account: id).class)
        .to eq(AddHolderSuccessMessage)
    end

    it 'returns a holder exists message if the holder is the main holder' do
      new_holder_id = create_holder_and_return_id
      message = test_controller.open_account(:Current, with: new_holder_id)
      account_id = message.new_account_id
      expect(test_controller.add_holder(new_holder_id, to_account: account_id)
        .class).to eq(HolderOnAccountMessage)
    end

    it 'cannot add the same holder to an account twice' do
      new_holder_id = create_holder_and_return_id
      id = open_account_and_return_id
      test_controller.add_holder(new_holder_id, to_account: id)
      expect(test_controller.add_holder(new_holder_id, to_account: id).class)
        .to eq(HolderOnAccountMessage)
    end
  end

  context 'when transacting' do
    it 'can make a deposit' do
      id = open_account_and_return_id
      expect(test_controller.accounts[id]).to receive(:deposit).with(50.00)
      test_controller.deposit(50.00, into: id)
    end

    it 'can give the balance of an account' do
      id = open_account_and_return_id
      message = test_controller.get_balance_of(id)
      expect(message.balance).to eq(0.00)
    end

    it 'can make a withdrawal' do
      id = open_account_and_return_id
      test_controller.deposit(50.00, into: id)
      expect(test_controller.accounts[id]).to receive(:withdraw).with(50.00)
      test_controller.withdraw(50.00, from: id)
    end

    it 'can make a transfer between two accounts' do
      id = open_account_and_return_id
      test_controller.deposit(10.00, into: id)
      id_2 = open_account_and_return_id
      expect(test_controller.accounts[id]).to receive(:withdraw).with(10.00)
      expect(test_controller.accounts[id_2]).to receive(:deposit).with(10.00)
      test_controller.transfer(10.00, from: id, to: id_2)
    end

    it 'returns an error if the donar account has insufficient funds' do
      id = open_account_and_return_id
      id_2 = open_account_and_return_id
      message = test_controller.transfer(10.00, from: id, to: id_2)
      expect(message.class).to eq(InsufficientFundsMessage)
    end

    it 'returns an error if a withdrawal is more than the account limit' do
      id = open_account_and_return_id
      test_controller.deposit 1000, into: id
      message = test_controller.withdraw 501, from: id
      expect(message.class).to eq(OverLimitMessage)
    end

    it 'raises an error if an invalid account id is entered' do
      message = test_controller.deposit(10.00, into: 57)
      expect(message.class).to eq(InvalidAccountMessage)
    end

    it 'can return all transactions of a given account' do
      id = open_account_and_return_id
      transaction = double :transaction, type: :deposit, amount: 50.00, date: '1/1/01'
      test_controller.accounts[id].add_transaction(transaction)
      expect(test_controller.get_transactions_of(id).transactions)
        .to eq([transaction])
    end

    it 'can return all accounts for a given holder' do
      holder_id = create_holder_and_return_id
      second_holder_id = create_holder_and_return_id
      message = test_controller.open_account(:Savings, with: holder_id)
      id = message.new_account_id
      test_controller.open_account(:Savings, with: second_holder_id)
      message = test_controller.open_account(:Current, with: holder_id)
      id_3 = message.new_account_id
      expect(test_controller.get_accounts_of(holder_id).accounts)
        .to eq([test_controller.accounts[id], test_controller.accounts[id_3]])
    end
  end
end
