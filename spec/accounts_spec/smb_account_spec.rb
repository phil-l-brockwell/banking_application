require 'accounts/smb_account'

describe 'SMBAccount' do
  context 'when initialised' do
    let(:test_holder)  { double :test_holder            }
    let(:test_account) { SMBAccount.new(test_holder, 1) }

    it 'can initialise with the correct type' do
      expect(test_account.type).to be(:SMB)
    end

    it 'has the correct limit' do
      expect(test_account.limit).to eq(300)
    end
  end
end
