require 'accounts/master_account'

describe 'MasterAccount' do
  let(:test_account) { MasterAccount.new }

  context 'when initialised' do
    it 'has the correct type' do
      expect(test_account.type).to eq(:Master)
    end

    it 'has a balance of one million' do
      expect(test_account.balance).to eq(100_000_0)
    end

    it 'has no daily limit' do
      expect(test_account).not_to respond_to(:daily_limit)
    end
  end
end
