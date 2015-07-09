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
      test_account.withdraw(100.00)
      test_account.reset_limit
      expect(test_account.daily_limit).to eq(300.00)
    end

    it 'knows when its daily limit is under' do
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

  context 'new holders' do
    it 'can add a holder' do
      test_account.add_holder(second_holder)
      expect(test_account.holders).to include(0 => second_holder)
    end

    it 'knows if it has a certain holder' do
      expect(test_account.has_holder?(holder)).to eq(true)
      test_account.add_holder(second_holder)
      expect(test_account.has_holder?(second_holder)).to eq(true)
    end

    it 'knows if it does not have a certain holder' do
      expect(test_account.has_holder?(second_holder)).to eq(false)
    end
  end
end
