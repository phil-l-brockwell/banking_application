require 'controller'

describe 'Controller' do
  let(:test_controller) { Controller.new }

  def create_holder
    test_controller.create_holder('Robert Pulson')
  end

  def open_account(type = :savings)
    holder_id = create_holder
    test_controller.open_account(type, holder_id)
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
      id = test_controller.holder_id
      expect(create_holder).to eq(id)
    end

    it 'gives the new holder the correct holder id' do
      id = create_holder
      expect(test_controller.holders[id].id).to eq(id)
    end

    it 'adds the new holder to the holders hash' do
      id = create_holder
      expect(test_controller.holders[id].name).to eq('Robert Pulson')
    end
  end

  context 'when opening an account' do
    it 'returns the new accounts id' do
      id = test_controller.account_id
      expect(open_account).to eq(id)
    end

    it 'increments the account id' do
      expect { open_account }.to change { test_controller.account_id }.by(1)
    end

    it 'gives the new account the correct account id' do
      id = open_account
      expect(test_controller.accounts[id].id).to eq(id)
    end

    it 'adds the new account to the accounts hash' do
      id = open_account
      expect(test_controller.accounts[id].main_holder.class).to eq(Holder)
      expect(test_controller.accounts[id]).to respond_to(:balance)
      expect(test_controller.accounts[id].type).to eq(:savings)
    end

    it 'can open different account types' do
      id = open_account(:current)
      expect(test_controller.accounts[id].type).to eq(:current)
    end

    it 'raises an error if an invalid holder number is entered' do
      expect { test_controller.open_account(:current, 57) }
        .to raise_error('Holder id 57 does not exist!')
    end
  end

  context 'when transacting' do
    it 'can make a deposit' do
      id = open_account
      expect(test_controller.accounts[id]).to receive(:deposit).with(50.00)
      test_controller.deposit_into(id, 50.00)
    end

    it 'can give the balance of an account' do
      id = open_account
      expect(test_controller.get_balance_of(id)).to eq(0.00)
    end

    it 'can make a withdrawal' do
      id = open_account
      expect(test_controller.accounts[id]).to receive(:withdraw).with(50.00)
      test_controller.withdraw_from(id, 50.00)
    end

    it 'can make a transfer between two accounts' do
      id = open_account
      test_controller.deposit_into(id, 10.00)
      id_2 = open_account
      expect(test_controller.accounts[id]).to receive(:withdraw).with(10.00)
      expect(test_controller.accounts[id_2]).to receive(:deposit).with(10.00)
      test_controller.transfer_between(id, id_2, 10.00)
    end

    it 'raises an error if the donar account has insufficient funds' do
      id = open_account
      id_2 = open_account
      expect { test_controller.transfer_between(id, id_2, 10.00) }
        .to raise_error('The withdrawal amount exceeds current balance!')
    end

    it 'can pay the interest on an account' do
      id = open_account
      test_controller.deposit_into(id, 10.00)
      expect { test_controller.pay_interest_on(id) }
        .to change { test_controller.accounts[id].balance }
    end

    it 'can add a holder to an account' do
      id = open_account
      new_holder_id = create_holder
      expect(test_controller.accounts[id]).to receive(:add_holder)
        .with(test_controller.holders[new_holder_id])
      test_controller.add_holder_to(id, new_holder_id)
    end

    it 'raises an error if an invalid account id is entered' do
      expect { test_controller.deposit_into(57, 10.00) }
        .to raise_error('Account id 57 does not exist!')
    end
  end

  it 'can return all transactions of a given account' do
    id = open_account
    new_transaction = double :new_transaction, type: :deposit, amount: 50.00
    test_controller.accounts[id].add_transaction(new_transaction)
    expect(test_controller.get_transactions_of(id)).to eq([new_transaction])
  end

  it 'can return all accounts for a given holder' do
    holder_id = create_holder
    second_holder_id = create_holder
    id = test_controller.open_account(:savings, holder_id)
    test_controller.open_account(:savings, second_holder_id)
    id_3 = test_controller.open_account(:current, holder_id)
    expect(test_controller.get_accounts_of(holder_id))
      .to eq([test_controller.accounts[id], test_controller.accounts[id_3]])
  end
end
