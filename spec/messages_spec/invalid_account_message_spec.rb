require 'messages/invalid_account_message'

describe 'InvalidAccountMessage' do
  context 'when initialised' do
    let(:test_message) { InvalidAccountMessage.new(43) }

    it 'knows the invalid account id' do
      expect(test_message.invalid_account_id).to eq(43)
    end

    it 'has the correct main text' do
      expect(test_message.main).to eq('Account ID: 43 does not exist.')
    end
  end
end
