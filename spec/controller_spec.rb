require 'controller'
require 'timecop'

describe 'Controller' do
  let(:test_controller) { Controller.new                          }
  let(:test_holder)     { double :test_holder                     }
  let(:second_holder)   { double :second_holder, id: 0            }
  let(:test_account)    { double :test_account, account_number: 1 }

  context 'when initialised' do
    it 'has a hash of accounts' do
      expect(test_controller).to respond_to(:accounts)
    end

    it 'has a hash of holders' do
      expect(test_controller).to respond_to(:holders)
    end

    it 'has a current account id' do
      expect(test_controller.account_id).to eq(0)
    end

    it 'has a current holder id' do
      expect(test_controller.holder_id).to eq(0)
    end
  end

  context 'when opening an account' do
    it 'returns the new accounts id' do
      num = test_controller.account_id
      expect(test_controller.open_account(:savings, test_holder))
        .to eq(num)
    end

    it 'increments the account id' do
      expect { test_controller.open_account(:current, test_holder) }
        .to change { test_controller.account_id }.by(1)
    end

    it 'gives the new account the correct account id' do
      num = test_controller.open_account(:current, test_holder)
      expect(test_controller.accounts[num].id).to eq(num)
    end

    it 'can open a savings account' do
      num = test_controller.open_account(:savings, test_holder)
      expect(test_controller.accounts[num].type).to eq(:savings)
    end
  end

  context 'when creating a holder' do
    it 'increments the holder number' do
      expect { test_controller.create_holder('Robert Pulson') }
        .to change { test_controller.holder_id }.by(1)
    end

    it 'returns the new holders id' do
      num = test_controller.holder_id
      expect(test_controller.create_holder('Robert Pulson'))
        .to eq(num)
    end

    it 'gives the new holder the correct holder id' do
      num = test_controller.create_holder('Robert Pulson')
      expect(test_controller.holders[num].id).to eq(num)
    end
  end

  context 'when transacting' do
    it 'can make a deposit' do
      num = test_controller.open_account(:savings, test_holder)
      expect(test_controller.accounts[num]).to receive(:deposit).with(50.00)
      test_controller.deposit_into(num, 50.00)
    end

    it 'can make a withdrawal' do
      num = test_controller.open_account(:savings, test_holder)
      expect(test_controller.accounts[num]).to receive(:withdraw).with(50.00)
      test_controller.withdraw_from(num, 50.00)
    end

    it 'can make a transfer between two accounts' do
      num_1 = test_controller.open_account(:savings, test_holder)
      test_controller.deposit_into(num_1, 10.00)
      num_2 = test_controller.open_account(:savings, test_holder)
      expect(test_controller.accounts[num_1]).to receive(:withdraw).with(10.00)
      expect(test_controller.accounts[num_2]).to receive(:deposit).with(10.00)
      test_controller.transfer_between(num_1, num_2, 10.00)
    end

    it 'raises an error if the donar account has insufficient funds' do
      num_1 = test_controller.open_account(:savings, test_holder)
      num_2 = test_controller.open_account(:savings, test_holder)
      expect { test_controller.transfer_between(num_1, num_2, 10.00) }
        .to raise_error('The withdrawal amount exceeds current balance!')
    end

    it 'can pay the interest on an account' do
      num_1 = test_controller.open_account(:savings, test_holder)
      test_controller.deposit_into(num_1, 10.00)
      expect { test_controller.pay_interest_on(num_1) }
        .to change { test_controller.accounts[num_1].balance }
    end

    it 'can add a holder to an account' do
      num_1 = test_controller.open_account(:savings, test_holder)
      expect(test_controller.accounts[num_1]).to receive(:add_holder)
        .with(second_holder)
      test_controller.add_holder_to(num_1, second_holder)
    end
  end
end
