require 'caretaker'
# require caretaker class for testing
require 'rufus-scheduler'
# require task scheduling library for testing
require 'timecop'
# require timecop for time related events
require 'modules/controller_item_store'
# require item store
require 'controllers/accounts_controller'
# require test subject

describe 'AccountsController' do
  # sets up test subject

  let(:accounts_ctrl) { AccountsController.instance }
  # create instance of controller
  let(:holder)        { double :holder, id: 1       }
  # create holder double for testing

  # helper method to create holder and return the id so we can perform tests
  def create_holder_and_return_id
    id = accounts_ctrl.holders.id
    accounts_ctrl.holders.create('Robert Pulson')
    id
  end

  # helper method to open and account and return the id so we can perform tests
  def open_account_and_return_id(type = 'savings')
    holder_id = create_holder_and_return_id
    id = accounts_ctrl.id
    accounts_ctrl.open(type, with: holder_id)
    id
  end

  context 'when opening an account' do
    # these tests will test behaviour related to opening an account

    it 'returns a message with the new accounts id' do
      id = accounts_ctrl.id
      expect(open_account_and_return_id).to eq(id)
    end

    it 'increments the account id' do
      expect { open_account_and_return_id }
        .to change { accounts_ctrl.id }.by(1)
    end

    it 'can open different account types' do
      id = open_account_and_return_id('current')
      expect(accounts_ctrl.store[id].type).to eq(:Current)
    end
  end

  context 'when scheduling interest payemnts' do
    # these tests will test behaviour related to interest payments

      it 'schedules new interest payments' do
        # this test will ensure a new interest payment is scheduled when an account is opened
        id = open_account_and_return_id
        # open account
        Timecop.scale(100_000_00)
        # timecop used to speed time up so we dont have to wait for one year
        expect(accounts_ctrl.store[id]).to receive(:deposit)
        # expect the account to receive an interest payment
        sleep(5)
        # wait for 5 seconds(1 year)
      end

      it 'does not schedule new interest payements for islamic accounts' do
        # test to ensure interest payments are not scheduled for islamic accounts
        id = open_account_and_return_id('islamic')
        # open account
        Timecop.scale(100_000_00)
        # timecop used to speed time up so we dont have to wait for one year
        expect(accounts_ctrl.store[id]).not_to receive(:deposit)
        # expect the account to receive an interest payment
        sleep(5)
        # wait for 5 seconds(1 year)
      end
  end

  context 'when depositing' do
    it 'can make a deposit' do
      id = open_account_and_return_id
      expect(accounts_ctrl.store[id]).to receive(:deposit).with(50.00)
      accounts_ctrl.deposit(50.00, into: id)
    end
  end

  context 'when withdrawing' do
    it 'can make a withdrawal' do
      id = open_account_and_return_id
      accounts_ctrl.deposit(50.00, into: id)
      expect(accounts_ctrl.store[id]).to receive(:withdraw).with(50.00)
      accounts_ctrl.withdraw(50.00, from: id)
    end

    it 'can schedule a limit to be reset when a withdrawal is made' do
      # test ensures a limit reset is performed 24 hours after a withdrawal is made
      id = open_account_and_return_id
      # create account
      accounts_ctrl.deposit(50.00, into: id)
      # deposit something so we can withdraw it
      accounts_ctrl.withdraw(50.00, from: id)
      # make a withdrawal
      Timecop.scale(100_000)
      # speed up time so we dont have to wait for 24 hours
      expect(accounts_ctrl.store[id]).to receive(:reset_limit)
      # expect the account to receive limit reset
      sleep(2)
      # wait for 2 seconds(24 hours)
    end

    it 'does not schedule a limit reset if one is already scheduled' do
      # test to ensure a limit reset is only performed once
      id = open_account_and_return_id
      # create an account
      accounts_ctrl.deposit(50.00, into: id)
      # make a deposit so we can withdraw
      expect(accounts_ctrl.task_manager).to receive(:in).once
      # expect the task manager to receive a new task once
      2.times { accounts_ctrl.withdraw(10.00, from: id) }
      # make two withdrawals
    end
  end

  context 'when making a transfer' do
    it 'can make a transfer between two accounts' do
      id = open_account_and_return_id
      accounts_ctrl.deposit(10.00, into: id)
      id_2 = open_account_and_return_id
      expect(accounts_ctrl.store[id]).to receive(:withdraw).with(10.00)
      expect(accounts_ctrl.store[id_2]).to receive(:deposit).with(10.00)
      accounts_ctrl.transfer(10.00, from: id, to: id_2)
    end
  end
end
