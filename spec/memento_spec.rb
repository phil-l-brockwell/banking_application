require 'memento'
# requires test subject

describe 'Memento' do
# sets up the test subject

  context 'when initialised' do
    # tests in this block will test for events exclusively after initialisation
    let(:transactions) { double :transactions }
    # creates a double transactions object
    let(:account) { double :account, id: 57, balance: 100, daily_limit: 200, transactions: transactions }
    # creates a double account object, with attributes that can be called
    let(:memento) { Memento.new(account) }
    # creates memento to run tests on

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
