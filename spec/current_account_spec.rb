require 'accounts/current_account'

describe 'CurrentAccount' do
  it 'can initialise with the correct type' do
    test_holder = double :test_holder
    test_current_account = CurrentAccount.new(test_holder, 1)
    expect(test_current_account.type).to be(:Current)
  end
end
