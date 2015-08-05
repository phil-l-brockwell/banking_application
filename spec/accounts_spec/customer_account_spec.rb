require 'exceptions/base_exception'
require 'exceptions/holder_on_account'
require 'accounts/customer_account'

describe 'CustomerAccount' do
  let(:holder)        { double :holder                 }
  let(:test_account)  { CustomerAccount.new(holder, 0) }
  let(:second_holder) { double :second_holder, id: 0   }

  context 'when initialized' do
    it 'has a main holder' do
      expect(test_account.main_holder).to eq(holder)
    end

    it 'has an account id' do
      expect(test_account.id).to eq(0)
    end
  end

  context 'limits' do
    it 'has a default daily limit of 300' do
      expect(test_account.daily_limit).to eq(300)
    end

    it 'updates its limit everytime a withdrawal is made' do
      test_account.deposit(100.00)
      expect { test_account.withdraw(100.00) }
        .to change { test_account.daily_limit }.by(-100.00)
    end

    it 'can reset its limit' do
      test_account.deposit(100.00)
      test_account.withdraw(100.00)
      test_account.reset_limit
      expect(test_account.daily_limit).to eq(300.00)
    end

    it 'knows when its daily limit is under' do
      test_account.deposit(100.00)
      test_account.withdraw(100.00)
      expect(test_account.breached?).to eq(true)
    end

    it 'knows when its daily limit is less than its limit' do
      expect(test_account.breached?).to eq(false)
    end

    it 'knows if it has a certain amount' do
      test_account.deposit(100)
      expect(test_account.contains?(100)).to eq(true)
    end

    it 'knows if it doesnt have a certain amount' do
      expect(test_account.contains?(100)).to eq(false)
    end

    it 'knows if its daily limit will allow a certain withdrawal' do
      test_account.deposit(100)
      expect(test_account.limit_allow?(100)).to eq(true)
    end

    it 'knows if its daily limit will not allow a certain withdrawal' do
      test_account.deposit(300)
      test_account.withdraw(300)
      expect(test_account.limit_allow?(100)).to eq(false)
    end
  end

  context 'overdraft' do
    it 'can sets its overdraft' do
      test_account.activate_overdraft(300)
      expect(test_account.overdraft).to eq(300)
    end

    it 'knows when it is overdrawn' do
      test_account.activate_overdraft(100)
      test_account.withdraw(50.00)
      expect(test_account.overdrawn?).to eq(true)
    end
  end

  context 'new holders' do
    it 'can add a holder' do
      test_account.add_holder(second_holder)
      expect(test_account.holders).to include(0 => second_holder)
    end

    it 'raises an error if it trys to add a holder that already exists' do
      test_account.add_holder(second_holder)
      expect { test_account.add_holder(second_holder) }
        .to raise_error(HolderOnAccount)
      expect { test_account.add_holder(holder) }
        .to raise_error(HolderOnAccount)
    end
  end

  context 'mementos' do
    it 'can return a memento with its current state' do
      memento = test_account.get_state
      expect(memento.balance).to eq(test_account.balance)
      expect(memento.id).to eq(test_account.id)
    end

    it 'can restore a previous state when passed memento' do
      expect(test_account.balance).to eq(0)
      transactions = ['transaction 1 ', 'transaction 2', 'transaction 3']
      memento = double :memento, balance: 200.00, daily_limit: 150.00, transactions: transactions
      test_account.restore_state(memento)
      expect(test_account.balance).to eq(200.00)
      expect(test_account.daily_limit).to eq(150.00)
      expect(test_account.transactions).to eq(transactions)
    end
  end
end
