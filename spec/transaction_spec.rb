require 'timecop'
# require timecop for testing timed events
require 'transaction'
# require transaction class to test

describe 'Transaction' do
  # set up a test subject
  let(:new_transaction) { Transaction.new(:deposit, 100) }
  # create an instance of a transaction to run the tests on
  # it can now be referred to as new_transaction

  it 'is initialised with a type' do
    # test to ensure a transaction is initilaised with the correct type
    # in the statement above it has been initialised so now we check its type
    expect(new_transaction.type).to eq(:deposit)
  end

  it 'is initialised with the current date and time' do
    # a transaction should automatically initialise with the current time and date
    Timecop.freeze
    # freezes the current time so time can be tested
    expect(new_transaction.date).to eq(Time.now.strftime('%a %d %b %Y'))
    # tests that current time is equal to the transactions date attribute
    Timecop.return
    # returns time to normal
  end

  it 'is initialised with a transaction amount' do
    # test to check that amount attribute was initialised correctly
    expect(new_transaction.amount).to eq(100)
  end
end
