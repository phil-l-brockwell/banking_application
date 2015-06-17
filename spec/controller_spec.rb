require 'controller'

describe 'Controller' do
  let(:test_controller) { Controller.new }

  it 'has a hash of accounts' do
    expect(test_controller).to respond_to(:accounts)
  end

  it 'has a hash of holders' do
    expect(test_controller).to respond_to(:holders)
  end

  it 'has a current holder number' do
    expect(test_controller.holder_number).to eq(0)
  end

  it 'can increment the holder number' do
    test_controller.increment_holder_number
    expect(test_controller.holder_number).to eq(1)
  end

  it 'can add a new holder to the hash with the correct account number' do
    current_holder_number = test_controller.holder_number
    test_holder = double :test_holder, id: current_holder_number
    expect(test_holder).to receive(:id)
    test_controller.add_holder(test_holder)
    expect(test_controller.holders).to include(current_holder_number => test_holder)
    expect(test_controller.holder_number).to eq(current_holder_number += 1)
  end

  it 'has a current account number' do
    expect(test_controller.account_number).to eq(0)
  end

  it 'can increment the account number' do
    test_controller.increment_account_number
    expect(test_controller.account_number).to eq(1)
  end

  it 'can add a new account with the correct account number' do
    current_account_number = test_controller.account_number
    new_account = double :new_account, account_number: current_account_number
    expect(new_account).to receive(:account_number)
    test_controller.add_account(new_account)
    expect(test_controller.accounts).to include(current_account_number => new_account)
    expect(test_controller.account_number).to eq(current_account_number += 1)
  end
end
