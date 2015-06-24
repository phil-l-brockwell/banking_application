require 'controller'

describe 'Controller' do
  let(:test_controller) { Controller.new                          }
  let(:test_holder)     { double :test_holder                     }
  let(:test_account)    { double :test_account, account_number: 1 }

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

  it 'increments the account number after an account is opened' do
    expect { test_controller.open_account(:current, test_holder) }
      .to change { test_controller.account_number }.by(1)
  end

  it 'can open a new account with the correct account number' do
    num = test_controller.account_number
    test_controller.open_account(:current, test_holder)
    expect(test_controller.accounts[num].account_number).to eq(num)
  end

  it 'can open a current account' do
    num = test_controller.account_number
    test_controller.open_account(:current, test_holder)
    expect(test_controller.accounts[num].type).to eq(:current)
  end

  it 'can open a savings account' do
    num = test_controller.account_number
    test_controller.open_account(:savings, test_holder)
    expect(test_controller.accounts[num].type).to eq(:savings)
  end
end
