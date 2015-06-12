require 'timecop'
require 'transaction'

describe 'Transaction' do

  let(:new_transaction) { Transaction.new(:deposit, 100) }

  it 'is initialised with a type' do
    expect(new_transaction.type).to eq(:deposit)
  end

  it 'is initialised with the current date and time' do
    Timecop.freeze
    expect(new_transaction.date).to eq(Time.now)
    Timecop.return
  end

  it 'is initialised with a transaction amount' do
    expect(new_transaction.amount).to eq(100)
  end
end
