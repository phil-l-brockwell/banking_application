require 'controller'

describe 'Controller' do
  let(:test_controller) { Controller.new      }
  let(:test_holder)     { double :test_holder }

  it 'has a hash of accounts' do
    expect(test_controller).to respond_to(:accounts)
  end

  it 'has a current account number' do
    expect(test_controller.account_number).to eq(0)
  end

  it 'can increment the account number' do
    test_controller.increment_account_number
    expect(test_controller.account_number).to eq(1)
  end

  it 'can create a new current account' do
    new_account = test_controller.create_account(:current, test_holder)
    expect(new_account.type).to eq(:current)
  end

  it 'increments the account number after an account is created' do
    current_account_number = test_controller.account_number
    test_controller.create_account(:current, test_holder)
    expect(test_controller.account_number).to eq(current_account_number += 1)
  end

  it 'can add a new account with the correct account number' do
    new_account = double :new_account, account_number: 1
    expect(new_account).to receive(:account_number)
    test_controller.add_account(new_account)
    expect(test_controller.accounts).to include(1 => new_account)
  end

  it 'can make a deposit into an account' do
    new_account = double :new_account
    expect(new_account).to receive(:deposit).with(10)
    test_controller.deposit_into(new_account, 10)
  end
end
