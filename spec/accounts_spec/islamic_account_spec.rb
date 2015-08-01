require 'accounts/islamic_account'

describe 'IslamicAccount' do
  context 'when initialised' do
    let(:holder)       { double :holder                }
    let(:test_account) { IslamicAccount.new(holder, 1) }

    it 'has the correct type' do
      expect(test_account.type).to eq(:Islamic)
    end
  end
end
