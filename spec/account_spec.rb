require 'account'

describe 'Account' do

  let(:test_account) { Account.new    }
  let(:holder)       { double :holder }

  it 'has a balance' do
    expect(test_account).to respond_to(:balance)
  end

  it 'is initialsed with zero balance' do
    expect(test_account.balance).to eq(0.00)
  end

  it 'can add a holder' do
    test_account.add(:holder)
    expect(test_account.holders).to eq([:holder])
  end

  it 'can make a deposit' do
    test_account.deposit(100)
    expect(test_account.balance).to eq(100.00)
  end

  it 'can make a withdrawal' do
    test_account.deposit(100)
    test_account.withdraw(100)
    expect(test_account.balance).to eq(0)
  end

end