require 'memento'

describe 'Memento' do
  context 'when initialised' do
    let(:transactions) { double :transactions }
    let(:account) { double :account, id: 57, balance: 100, daily_limit: 200, transactions: transactions }
    let(:memento) { Memento.new(account) }

    it 'has a balance' do
      expect(memento.balance).to eq(100.00)
    end

    it 'has an account id' do
      expect(memento.id).to eq(57)
    end

    it 'has the daily limit' do
      expect(memento.daily_limit).to eq(200)
    end

    it 'has the transactions' do
      expect(memento.transactions).to eq(transactions)
    end
  end
end
