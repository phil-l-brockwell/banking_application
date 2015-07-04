require 'accounts/business_account'

describe 'BusinessAccount' do
  it 'can initialise with the correct type' do
    test_holder = double :test_holder
    test_business_account = BusinessAccount.new(test_holder, 1)
    expect(test_business_account.type).to be(:Business)
  end
end
