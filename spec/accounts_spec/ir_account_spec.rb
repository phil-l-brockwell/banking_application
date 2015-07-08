require 'accounts/ir_account'

describe 'IRAccount' do
  context 'when initialised' do
    let(:test_holder)  { double :test_holder           }
    let(:test_account) { IRAccount.new(test_holder, 1) }

    it 'can initialise with the correct type' do
      expect(test_account.type).to be(:IR)
    end
  end
end
