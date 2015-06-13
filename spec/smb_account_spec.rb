require 'smb_account'

describe 'SMBAccount' do
  it 'can initialise with the correct type' do
    test_holder = double :test_holder
    test_smb_account = SMBAccount.new(test_holder, 1)
    expect(test_smb_account.type).to be(:smb)
  end
end
