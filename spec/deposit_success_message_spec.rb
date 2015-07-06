require 'deposit_success_message'

describe 'DepositSuccessMessage' do
  context 'when initialised' do
    let(:test_message) { DepositSuccessMessage.new(500.00) }

    it 'knows the deposit amount' do
      expect(test_message.amount).to eq(500.00)
    end

    it 'has the correct output' do
      expect(test_message.output).to eq('Transaction Successful. £500.0 deposited.')
    end
  end
end
