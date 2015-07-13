require 'singleton'
require 'boundary'
require_relative '../modules/controller_item_store'
require_relative '../modules/overdraft_module'
require_relative '../modules/interest_module'
# Definition of Controller Class
class AccountsController
  include ControllerItemStore, Overdrafts, Interest, Singleton

  attr_reader :holders, :task_manager

  def initialize
    super
    @holders      = HoldersController.instance
    @task_manager = Rufus::Scheduler.new
  end

  def open(type, with:)
    begin
      account = create type, (holders.find with)
      add account
      init_yearly_interest_for account
      boundary.render AccountSuccessMessage.new(account)
    rescue ItemExistError => message
      boundary.render message
    end
  end

  def deposit(amount, into:)
    begin
      account = find into
      account.deposit amount
      boundary.render DepositSuccessMessage.new(amount)
    rescue ItemExistError => message
      boundary.render message
    end
  end

  def withdraw(amount, from:)
    begin
      account = find from
      init_limit_reset_for account unless account.breached?
      account.withdraw amount
      boundary.render WithdrawSuccessMessage.new(amount)
    rescue ItemExistError => message
      boundary.render message
    rescue OverLimit => message
      boundary.render message
    rescue InsufficientFunds => message
      boundary.render message
    end
  end

  def get_balance_of(id)
    begin
      account = find id
      boundary.render BalanceMessage.new(account)
    rescue ItemExistError => message
      boundary.render message
    end
  end

  def transfer(amount, from:, to:)
    begin
      donar = find from
      recipitent = find to
      init_limit_reset_for donar unless donar.breached?
      donar.withdraw amount
      recipitent.deposit amount
      boundary.render TransferSuccessMessage.new(amount)
    rescue ItemExistError => message
      boundary.render message
    rescue OverLimit => message
      boundary.render message
    rescue InsufficientFunds => message
      boundary.render message
    end
  end

  def add_holder(id, to:)
    begin
      holder = holders.find id
      account = find to
      account.add_holder holder
      boundary.render AddHolderSuccessMessage.new(holder, account)
    rescue ItemExistError => message
      boundary.render message
    rescue HolderOnAccount => message
      boundary.render message
    end
  end

  def get_transactions_of(id)
    begin
      transactions = (find id).transactions
      boundary.render TransactionsMessage.new(transactions)
    rescue ItemExistError => message
      boundary.render message
    end
  end

  def get_accounts_of(id)
    begin
      holder = holders.find id
      accounts = store.select { |_, a| a.holder? holder }.values
      boundary.render DisplayAccountsMessage.new(accounts)
    rescue ItemExistError => message
      boundary.render message
    end
  end

  def reset_limit_on(account)
    account.reset_limit
  end

  def pay_interest_on(account)
    amount = calculate_interest_on account
    account.deposit amount
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
