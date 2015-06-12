require 'transaction'

describe 'Transaction' do

  it 'is initialised with a type' do
    new_transaction = Transaction.new(:deposit)
    expect(new_transaction.type).to eq(:deposit)
  end
  
end
