require 'messages/success_message'

describe 'SuccessMessage' do
  context 'when initialised' do
    it 'has the correct header' do
      test_message = SuccessMessage.new
      expect(test_message.header).to eq('Transaction Successful.')
    end
  end
end
