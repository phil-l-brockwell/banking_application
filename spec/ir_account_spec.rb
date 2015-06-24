require 'accounts/ir_account'

describe 'IRAccount' do
  it 'can initialise with the correct type' do
    test_holder = double :test_holder
    test_ir_account = IRAccount.new(test_holder, 1)
    expect(test_ir_account.type).to be(:ir)
  end
end
