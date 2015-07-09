require 'singleton'
require_relative 'controller_item_store'
require 'controllers/loans_controller'
# Definition of Controller Class
class AccountsController
  include ControllerItemStore
  include Singleton

  attr_reader :holders, :task_manager

  def initialize
    super
    @holders      = HoldersController.instance
    @interest     = InterestController.instance
    @loans        = LoansController.instance
    @task_manager = Rufus::Scheduler.new
  end

  def open(type, with:)
    holder = holders.exist? with
    account = create_account type, holder
    add account
    init_yearly_interest_for account
    AccountSuccessMessage.new(account)
  end

  def deposit(amount, into:)
    account = exist? into
    account.deposit amount
    DepositSuccessMessage.new(amount)
  end

  def withdraw(amount, from:)
    account = exist? from
    return InsufficientFundsMessage.new(account) unless check_balance_of account, with: amount
    return OverLimitMessage.new(account) if check_limit_of account, with: amount
    init_limit_reset_for account unless account.under_limit?
    account.withdraw amount
    WithdrawSuccessMessage.new(amount)
  end

  def get_balance_of(id)
    account = exist? id
    BalanceMessage.new(account)
  end

  def transfer(amount, from:, to:)
    donar = exist? from
    recipitent = exist? to
    return InsufficientFundsMessage.new(donar) unless check_balance_of donar, with: amount
    return OverLimitMessage.new(donar) if check_limit_of donar, with: amount
    donar.withdraw amount
    recipitent.deposit amount
    TransferSuccessMessage.new(amount)
  end

  def add_holder(id, to_account:)
    holder = holders.exist? id
    account = exist? to_account
    return HolderOnAccountMessage.new(holder, account) if check_holders_of account, with: holder
    account.add_holder holder
    AddHolderSuccessMessage.new(holder, account)
  end

  def get_transactions_of(id)
    account = exist? id
    transactions = account.transactions
    TransactionsMessage.new(transactions)
  end

  def get_accounts_of(id)
    holder = holders.exist? id
    accounts = store.select { |_, a| a.main_holder == holder }.values
    DisplayAccountsMessage.new(accounts)
  end

  def reset_limit_on(account)
    account.reset_limit
  end

  def pay_interest_on(account)
    amount = @interest.calculate_interest_on account
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
    @task_manager.every '1y' do pay_interest_on account end
  end

  def init_limit_reset_for(account)
    @task_manager.in '1d' do reset_limit_on account end
  end

  def check_holders_of(account, with:)
    account.main_holder == with || account.holders.value?(with)
  end

  def check_balance_of(account, with:)
    account.balance >= with
  end

  def check_limit_of(account, with:)
    with > account.daily_limit
  end

  def create_account(type, holder)
    account_class = ACCOUNT_CLASSES[type]
    account_class.new(holder, current_id)
  end
end
