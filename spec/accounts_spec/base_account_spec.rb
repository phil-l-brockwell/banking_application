require 'accounts/base_account'

describe 'BaseAccount' do
  let(:test_account)  { BaseAccount.new(:holder, 1)  }

  context 'when initialsed' do
    it 'has zero balance' do
      expect(test_account.balance).to eq(0.00)
    end

    it 'has a type' do
      expect(test_account).to respond_to(:type)
    end
  end

  context 'deposits' do
    it 'can make a deposit' do
      test_account.deposit(100.00)
      expect(test_account.balance).to eq(100.00)
    end
  end

  context 'withdrawals' do
    it 'can make a withdrawal' do
      test_account.deposit(100.00)
      test_account.withdraw(100.00)
      expect(test_account.balance).to eq(0.00)
    end
  end

  context 'transactions' do
    it 'can add a new transaction' do
      new_transaction = double :new_transaction
      test_account.add_transaction(new_transaction)
      expect(test_account.transactions).to eq([new_transaction])
    end

    it 'creates a transaction after a deposit is made' do
      expect { test_account.deposit(100.00) }
        .to change { test_account.transactions.count }.by(1)
    end

    it 'creates a transaction after a successful withdrawal is made' do
      test_account.deposit(100.00)
      expect { test_account.withdraw(100.00) }
        .to change { test_account.transactions.count }.by(1)
    end
  end
end
