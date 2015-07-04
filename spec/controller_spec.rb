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

  def open_account(type = :savings, holder_id = test_holder.id)
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
      num = test_controller.holder_id
      expect(create_holder).to eq(num)
    end

    it 'gives the new holder the correct holder id' do
      num = create_holder
      expect(test_controller.holders[num].id).to eq(num)
    end

    it 'adds the new holder to the holders hash' do
      num = create_holder
      expect(test_controller.holders[num].name).to eq('Robert Pulson')
    end
  end

  context 'when opening an account' do
    it 'returns the new accounts id' do
      holder_num = create_holder
      num = test_controller.account_id
      expect(open_account(:savings, holder_num)).to eq(num)
    end

    it 'increments the account id' do
      holder_num = create_holder
      expect { open_account(:savings, holder_num) }
        .to change { test_controller.account_id }.by(1)
    end

    it 'gives the new account the correct account id' do
      holder_num = create_holder
      num = open_account(:savings, holder_num)
      expect(test_controller.accounts[num].id).to eq(num)
    end

    it 'adds the new account to the accounts hash' do
      holder_num = create_holder
      num = open_account(:savings, holder_num)
      expect(test_controller.accounts[num].main_holder.id).to eq(holder_num)
      expect(test_controller.accounts[num]).to respond_to(:balance)
      expect(test_controller.accounts[num].type).to eq(:savings)
    end

    it 'can open different account types' do
      holder_num = create_holder
      num = open_account(:current, holder_num)
      expect(test_controller.accounts[num].type).to eq(:current)
    end

    it 'raises an error if an invalid holder number is entered' do
      expect { open_account(:current, 57) }
        .to raise_error('Holder number 57 does not exist!')
    end
  end

  context 'when transacting' do
    it 'can make a deposit' do
      holder_num = create_holder
      num = open_account(:savings, holder_num)
      expect(test_controller.accounts[num]).to receive(:deposit).with(50.00)
      test_controller.deposit_into(num, 50.00)
    end

    it 'can make a withdrawal' do
      holder_num = create_holder
      num = open_account(:savings, holder_num)
      expect(test_controller.accounts[num]).to receive(:withdraw).with(50.00)
      test_controller.withdraw_from(num, 50.00)
    end

    it 'can make a transfer between two accounts' do
      holder_num = create_holder
      num_1 = open_account(:savings, holder_num)
      test_controller.deposit_into(num_1, 10.00)
      num_2 = open_account(:savings, holder_num)
      expect(test_controller.accounts[num_1]).to receive(:withdraw).with(10.00)
      expect(test_controller.accounts[num_2]).to receive(:deposit).with(10.00)
      test_controller.transfer_between(num_1, num_2, 10.00)
    end

    it 'raises an error if the donar account has insufficient funds' do
      holder_num = create_holder
      num_1 = open_account(:savings, holder_num)
      num_2 = open_account(:savings, holder_num)
      expect { test_controller.transfer_between(num_1, num_2, 10.00) }
        .to raise_error('The withdrawal amount exceeds current balance!')
    end

    it 'can pay the interest on an account' do
      holder_num = create_holder
      num_1 = open_account(:savings, holder_num)
      test_controller.deposit_into(num_1, 10.00)
      expect { test_controller.pay_interest_on(num_1) }
        .to change { test_controller.accounts[num_1].balance }
    end

    it 'can add a holder to an account' do
      holder_num = create_holder
      num_1 = open_account(:savings, holder_num)
      expect(test_controller.accounts[num_1]).to receive(:add_holder)
        .with(second_holder)
      test_controller.add_holder_to(num_1, second_holder)
    end
  end

  it 'can return all transactions of a given account' do
    holder_num = create_holder
    num = open_account(:savings, holder_num)
    new_transaction = double :new_transaction, type: :deposit, amount: 50.00
    test_controller.accounts[num].add_transaction(new_transaction)
    expect(test_controller.get_transactions_of(num)).to eq([new_transaction])
  end

  it 'can return all accounts for a given holder' do
    holder_num = create_holder
    second_holder_num = create_holder
    num = open_account(:savings, holder_num)
    open_account(:savings, second_holder_num)
    num_3 = open_account(:current, holder_num)
    expect(test_controller.get_accounts_of(holder_num))
      .to eq([test_controller.accounts[num], test_controller.accounts[num_3]])
  end
end
