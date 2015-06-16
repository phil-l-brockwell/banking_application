require 'controller'

describe 'Controller' do
  let(:test_controller) { Controller.new }

  it 'has an array of accounts' do
    expect(test_controller).to respond_to(:accounts)
  end

  it 'has a hash of holders' do
    expect(test_controller).to respond_to(:holders)
  end

  it 'can add a new holder' do
    test_holder = double :test_holder
    expect(test_holder).to receive(:add_id)
    test_controller.add_holder(test_holder)
    expect(test_controller.holders.last).to eq(test_holder)
  end

  it 'can add a new account' do
    new_account = double :new_account
    test_controller.add_account(new_account)
    expect(test_controller.accounts.last).to eq(:new_account)
  end
end
