require 'messages/base_message'

describe 'BaseMessage' do
  context 'when initialised' do
    let(:test_object)  { double :object               }
    let(:test_message) { BaseMessage.new(test_object) }

    it 'has an output' do
      expect(test_message).to respond_to(:output)
    end

    it 'builds the correct output' do
      test_message.header = 'this is a header'
      test_message.main = ['this is the main message']
      expect(test_message.output).to eq(['this is a header',
                                         'this is the main message'])
    end
  end
end
