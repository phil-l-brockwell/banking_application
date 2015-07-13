require 'messages/withdraw_success'

describe 'WithdrawSuccessMessage' do
  context 'when initialised' do
    let(:test_message) { WithdrawSuccessMessage.new(200.00) }

    it 'knows the deposit amount' do
      expect(test_message.amount).to eq(200.00)
    end

    it 'has the correct main text' do
      expect(test_message.main[0]).to eq('£200.0 withdrawn.')
    end
  end
end
