require 'messages/transfer_success'

describe 'TransferSuccessMessage' do
  context 'when initialised' do
    let(:test_message) { TransferSuccessMessage.new(5000) }

    it 'knows the amount transferred' do
      expect(test_message.amount).to eq(5000)
    end

    it 'has the correct main text' do
      expect(test_message.main[0]).to eq('£5000 transferred.')
    end
  end
end
