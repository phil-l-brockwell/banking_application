require 'accounts/savings_account'

describe 'SavingsAccount' do
  it 'can initialise with the correct type' do
    test_holder = double :test_holder
    test_savings_account = SavingsAccount.new(test_holder, 1)
    expect(test_savings_account.type).to be(:savings)
  end
end
