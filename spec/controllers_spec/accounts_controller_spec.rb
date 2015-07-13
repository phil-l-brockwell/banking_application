require 'rufus-scheduler'
require 'timecop'
require 'modules/controller_item_store'
require 'controllers/accounts_controller'

describe 'AccountsController' do
  let(:accounts_ctrl) { AccountsController.instance }
  let(:holder)        { double :holder, id: 1       }

  def create_holder_and_return_id
    id = accounts_ctrl.holders.id
    accounts_ctrl.holders.create('Robert Pulson')
    id
  end

  def open_account_and_return_id(type = :Savings)
    holder_id = create_holder_and_return_id
    id = accounts_ctrl.id
    accounts_ctrl.open(type, with: holder_id)
    id
  end

  context 'when opening an account' do
    it 'returns a message with the new accounts id' do
      id = accounts_ctrl.id
      expect(open_account_and_return_id).to eq(id)
    end

    it 'increments the account id' do
      expect { open_account_and_return_id }
        .to change { accounts_ctrl.id }.by(1)
    end

    it 'can open different account types' do
      id = open_account_and_return_id(:Current)
      expect(accounts_ctrl.store[id].type).to eq(:Current)
    end

    it 'schedules new interest payments' do
      id = open_account_and_return_id
      Timecop.scale(100_000_00)
      expect(accounts_ctrl.store[id]).to receive(:deposit)
      sleep(5)
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
      id = open_account_and_return_id
      accounts_ctrl.deposit(50.00, into: id)
      accounts_ctrl.withdraw(50.00, from: id)
      Timecop.scale(100_000)
      expect(accounts_ctrl.store[id]).to receive(:reset_limit)
      sleep(2)
    end

    it 'does not schedule a limit reset if one is already scheduled' do
      id = open_account_and_return_id
      accounts_ctrl.deposit(50.00, into: id)
      expect(accounts_ctrl.task_manager).to receive(:in).once
      2.times { accounts_ctrl.withdraw(10.00, from: id) }
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

  context 'when transacting' do
    it 'can reset the limit on an account' do
      id = open_account_and_return_id
      expect(accounts_ctrl.store[id]).to receive(:reset_limit)
      accounts_ctrl.reset_limit_on(accounts_ctrl.store[id])
    end
  end
end
