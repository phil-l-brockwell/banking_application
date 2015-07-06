require 'base_message'

describe 'BaseMessage' do
  context 'when initialised' do
    let(:test_object)  { double :object               }
    let(:test_message) { BaseMessage.new(test_object) }

    it 'has an output' do
      expect(test_message).to respond_to(:output)
    end
  end
end
