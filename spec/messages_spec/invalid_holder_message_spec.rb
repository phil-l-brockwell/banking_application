require 'messages/error_message'
require 'messages/invalid_holder_message'

describe 'InvalidHolderMessage' do
  context 'when initialised' do
    let(:test_message) { InvalidHolderMessage.new(69) }

    it 'knows the invalid holder ID' do
      expect(test_message.invalid_holder_id).to eq(69)
    end

    it 'has the correct main text' do
      expect(test_message.main)
        .to eq('Holder ID: 69 does not exist.')
    end
  end
end
