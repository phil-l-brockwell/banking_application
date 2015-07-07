require 'accounts/islamic_account'

describe 'IslamicAccount' do
  context 'when initialised' do
    let(:holder)       { double :holder                }
    let(:test_account) { IslamicAccount.new(holder, 1) }

    it 'has the correct type' do
      expect(test_account.type).to eq(:Islamic)
    end

    it 'has a nil interest rate' do
      expect(test_account.interest_rate).to eq(nil)
    end

    it 'has no interest rate method' do
      expect(test_account).not_to respond_to(:add_interest)
    end
  end
end
