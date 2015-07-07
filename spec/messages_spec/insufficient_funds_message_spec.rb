require 'messages/insufficient_funds_message'

describe 'InsufficientFundsMessage' do
  context 'when initialised' do
    let(:account)      { double :account, id: 2 }
    let(:test_message) { InsufficientFundsMessage.new(account) }

    it 'knows the account id' do
      expect(test_message.account_id).to eq(2)
    end

    it 'has the correct output' do
      expect(test_message.output).to eq('Transaction Error. Account ID: 2 has insufficient funds.')
    end
  end
end
