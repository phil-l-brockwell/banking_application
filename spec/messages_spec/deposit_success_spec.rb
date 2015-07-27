require 'messages/deposit_success'

describe 'DepositSuccessMessage' do
  context 'when initialised' do
    let(:test_message) { DepositSuccessMessage.new(500.00) }

    it 'has the correct main text' do
      expect(test_message.main[0]).to eq('£500.00 deposited.')
    end
  end
end
