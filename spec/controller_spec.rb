require 'controller'
require 'timecop'

describe 'Controller' do
  let(:test_controller) { Controller.new                          }
  let(:test_holder)     { double :test_holder, id: 1              }
  let(:second_holder)   { double :second_holder, id: 0            }
  let(:test_account)    { double :test_account, account_number: 1 }

  def create_holder
    test_controller.create_holder('Robert Pulson')
  end

  def open_account(type = :savings, holder = test_holder)
    test_controller.open_account(type, holder)
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
  end

  context 'when creating a holder' do
    it 'increments the holder number' do
      expect { create_holder }.to change { test_controller.holder_id }.by(1)
    end

    it 'returns the new holders id' do
      new_id = test_controller.holder_id
      expect(create_holder).to eq(new_id)
    end

    it 'gives the new holder the correct holder id' do
      new_id = create_holder
      expect(test_controller.holders[new_id].id).to eq(new_id)
    end

    it 'adds the new holder to the holders hash' do
      new_id = create_holder
      expect(test_controller.holders[new_id].name).to eq('Robert Pulson')
    end
  end

  context 'when opening an account' do
    it 'returns the new accounts id' do
      new_id = test_controller.account_id
      expect(open_account).to eq(new_id)
    end

    it 'increments the account id' do
      expect { open_account }.to change { test_controller.account_id }.by(1)
    end

    it 'gives the new account the correct account id' do
      new_id = open_account
      expect(test_controller.accounts[new_id].id).to eq(new_id)
    end

    it 'adds the new account to the accounts hash' do
      new_id = open_account
      expect(test_controller.accounts[new_id].main_holder).to eq(test_holder)
      expect(test_controller.accounts[new_id]).to respond_to(:balance)
      expect(test_controller.accounts[new_id].type).to eq(:savings)
    end

    it 'can open different account types' do
      new_id = open_account(:current)
      expect(test_controller.accounts[new_id].type).to eq(:current)
    end
  end

  context 'when transacting' do
    it 'can make a deposit' do
      new_id = open_account
      expect(test_controller.accounts[new_id]).to receive(:deposit).with(50.00)
      test_controller.deposit_into(new_id, 50.00)
    end

    it 'can make a withdrawal' do
      new_id = open_account
      expect(test_controller.accounts[new_id]).to receive(:withdraw).with(50.00)
      test_controller.withdraw_from(new_id, 50.00)
    end

    it 'can make a transfer between two accounts' do
      new_id = open_account
      test_controller.deposit_into(new_id, 10.00)
      new_id_2 = open_account
      expect(test_controller.accounts[new_id]).to receive(:withdraw).with(10.00)
      expect(test_controller.accounts[new_id_2]).to receive(:deposit).with(10.00)
      test_controller.transfer_between(new_id, new_id_2, 10.00)
    end

    it 'raises an error if the donar account has insufficient funds' do
      new_id = open_account
      new_id_2 = open_account
      expect { test_controller.transfer_between(new_id, new_id_2, 10.00) }
        .to raise_error('The withdrawal amount exceeds current balance!')
    end

    it 'can pay the interest on an account' do
      new_id = open_account
      test_controller.deposit_into(new_id, 10.00)
      expect { test_controller.pay_interest_on(new_id) }
        .to change { test_controller.accounts[new_id].balance }
    end

    it 'can add a holder to an account' do
      new_id = open_account
      expect(test_controller.accounts[new_id]).to receive(:add_holder)
        .with(second_holder)
      test_controller.add_holder_to(new_id, second_holder)
    end
  end

  it 'can return all transactions of a given account' do
    new_id = open_account
    new_transaction = double :new_transaction, type: :deposit, amount: 50.00
    test_controller.accounts[new_id].add_transaction(new_transaction)
    expect(test_controller.get_transactions_of(new_id))
      .to eq([new_transaction])
  end

  it 'can return all accounts for a given holder' do
    new_id = open_account
    open_account(:savings, second_holder)
    new_id_3 = open_account
    expect(test_controller.get_accounts_of(test_holder.id))
      .to eq([test_controller.accounts[new_id], test_controller.accounts[new_id_3]])
  end
end
