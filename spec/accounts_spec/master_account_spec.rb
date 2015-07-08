require 'accounts/master_account'

describe 'MasterAccount' do
  let(:test_account) { MasterAccount.new }

  context 'when initialised' do
    it 'has the correct type' do
      expect(test_account.type).to eq(:Master)
    end

    it 'has a balance of one million' do
      expect(test_account.balance).to eq(1000000)
    end

    it 'has no daily limit' do
      expect(test_account).not_to respond_to(:daily_limit)
    end
  end

  context 'when making withdrawals' do
    it 'is never under limit' do
      test_account.withdraw(1000000000)
      expect(test_account.under_limit?).to eq(false)
    end
  end
end
