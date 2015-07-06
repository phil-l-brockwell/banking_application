require 'messages/balance_message'

describe 'BalanceMessage' do
  context 'when initialised' do
    let(:account)      { double :account, balance: 51.52, id: 76 }
    let(:test_message) { BalanceMessage.new(account)             }

    it 'knows the balance' do
      expect(test_message.balance).to eq(51.52)
    end

    it 'knows the account id' do
      expect(test_message.account_id).to eq(76)
    end

    it 'has the correct output' do
      expect(test_message.output)
        .to eq('Transaction Successful. Balance of Account ID: 76 is £51.52')
    end
  end
end
