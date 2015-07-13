require 'messages/balance'

describe 'BalanceMessage' do
  context 'when initialised' do
    let(:account)      { double :account, output_balance: '£51.52', id: 76 }
    let(:test_message) { BalanceMessage.new(account)             }

    it 'knows the balance' do
      expect(test_message.balance).to eq('£51.52')
    end

    it 'knows the account id' do
      expect(test_message.account_id).to eq(76)
    end

    it 'has the correct main text' do
      expect(test_message.main[0])
        .to eq('Balance of Account ID: 76 is £51.52')
    end
  end
end
