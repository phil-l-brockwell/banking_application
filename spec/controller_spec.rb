require 'controller'

describe 'Controller' do
  let(:test_controller) { Controller.new }

  it 'has an array of accounts' do
    expect(test_controller).to respond_to(:accounts)
  end

  it 'has an array of holders' do
    expect(test_controller).to respond_to(:holders)
  end

  it 'can add a new holder' do
    new_holder = double :new_holder
    test_controller.add_holder(:new_holder)
    expect(test_controller.holders.last).to eq(:new_holder)
  end

  it 'can add a new account' do
    new_account = double :new_account
    test_controller.add_account(:new_account)
    expect(test_controller.accounts.last).to eq(:new_account)
  end
end
