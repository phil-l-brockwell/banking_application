require 'accounts/lcr_account'

describe 'LCRAccount' do
  context 'when initialised' do
    let(:holder) { double :holder }
    let(:test_account) { LCRAccount.new(holder, 3) }

    it 'has the correct type' do
      expect(test_account.type).to be(:LCR)
    end
  end
end
