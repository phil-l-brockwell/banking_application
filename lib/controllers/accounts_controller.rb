require 'singleton'
# require 'boundary'
require_relative '../modules/controller_item_store'
require_relative '../modules/overdraft'
# Definition of Controller Class
class AccountsController
  include ControllerItemStore, Overdrafts, Singleton

  attr_reader :holders, :task_manager, :master

  def initialize
    super
    @master       = MasterAccount.new
    @holders      = HoldersController.instance
    @task_manager = Rufus::Scheduler.new
  end

  def open(type, with:)
    account = create type, (holders.find with)
    add account
    init_yearly_interest_for account
    boundary.render AccountSuccessMessage.new(account)
  rescue ItemExist => message
    boundary.render message
  end

  def deposit(amount, into:)
    account = find into
    account.deposit amount
    boundary.render DepositSuccessMessage.new(amount)
  rescue ItemExist => message
    boundary.render message
  end

  def withdraw(amount, from:)
    account = find from
    init_limit_reset_for account unless account.breached?
    account.withdraw amount
    boundary.render WithdrawSuccessMessage.new(amount)
  rescue ItemExist, OverLimit, InsufficientFunds => message
    boundary.render message
  end

  def get_balance_of(id)
    account = find id
    boundary.render BalanceMessage.new(account)
  rescue ItemExist => message
    boundary.render message
  end

  def transfer(amount, from:, to:)
    donar = find from
    previous_state = donar.get_state
    donar.withdraw amount
    (find to).deposit amount
    init_limit_reset_for donar unless donar.breached?
    boundary.render TransferSuccessMessage.new(amount)
  rescue ItemExist, OverLimit, InsufficientFunds => message
    donar.restore_state previous_state if previous_state
    boundary.render message
  end

  def add_holder(id, to:)
    holder = holders.find id
    account = find to
    account.add_holder holder
    boundary.render AddHolderSuccessMessage.new(holder, account)
  rescue ItemExist, HolderOnAccount => message
    boundary.render message
  end

  def get_transactions_of(id)
    transactions = (find id).transactions
    boundary.render TransactionsMessage.new(transactions)
  rescue ItemExist => message
    boundary.render message
  end

  def get_accounts_of(id)
    holder = holders.find id
    accounts = store.select { |_, a| a.holder? holder }.values
    boundary.render DisplayAccountsMessage.new(accounts)
  rescue ItemExist => message
    boundary.render message
  end

  def reset_limit_on(account)
    account.reset_limit
  end

  def pay_interest_on(account)
    interest = (account.balance * account.interest_rate).abs
    if account.overdrawn?
      account.withdraw interest
      master.deposit interest
    else
      master.withdraw interest
      account.deposit interest
    end
  end

  ACCOUNT_CLASSES = { :Current      => CurrentAccount,
                      :Savings      => SavingsAccount,
                      :Business     => BusinessAccount,
                      :IR           => IRAccount,
                      :SMB          => SMBAccount,
                      :Student      => StudentAccount,
                      :HighInterest => HighInterestAccount,
                      :Islamic      => IslamicAccount,
                      :Private      => PrivateAccount,
                      :LCR          => LCRAccount          }

  private

  def init_yearly_interest_for(account)
    task_manager.every '1y' do
      pay_interest_on account
    end
  end

  def init_limit_reset_for(account)
    task_manager.in '1d' do
      reset_limit_on account
    end
  end

  def create(type, holder)
    account_class = ACCOUNT_CLASSES[type]
    account_class.new(holder, current_id)
  end
end
