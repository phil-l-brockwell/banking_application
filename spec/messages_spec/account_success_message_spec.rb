require 'messages/base_message'
require 'messages/success_message'
require 'messages/account_success_message'

describe 'AccountSuccessMessage' do
  context 'when initialised' do
    let(:test_account) { double :account, id: 0    }
    let(:test_message) { AccountSuccessMessage.new(test_account) }

    it 'knows the new account id' do
      expect(test_message.new_account_id).to eq(0)
    end

    it 'has the correct main text' do
      expect(test_message.main[0])
        .to eq('New Account created. ID number is: 0')
    end
  end
end
