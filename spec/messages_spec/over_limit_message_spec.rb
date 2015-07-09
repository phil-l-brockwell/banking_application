require 'messages/error_message'
require 'messages/over_limit_message'

describe 'OverLimitMessage' do
  context 'when initialised' do
    let(:account)      { double :account, id: 3        }
    let(:test_message) { OverLimitMessage.new(account) }

    it 'knows the account id' do
      expect(test_message.account_id).to eq(3)
    end

    it 'has the correct main text' do
      expect(test_message.main[0])
        .to eq('Account ID: 3 has reached its daily limit.')
    end
  end
end
