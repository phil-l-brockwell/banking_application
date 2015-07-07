require 'accounts/private_account'

describe 'PrivateAccount' do
  context 'when initialised' do
    let(:holder)       { double :holder                }
    let(:test_account) { PrivateAccount.new(holder, 5) }

    it 'has the correct type' do
      expect(test_account.type).to eq(:Private)
    end
  end
end
