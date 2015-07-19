require 'singleton'
require_relative '../modules/controller_item_store'
require_relative '../modules/overdraft'
require_relative '../modules/interest'
# Definition of Controller Class
class AccountsController
  include ControllerItemStore, Overdrafts, Singleton, Interest

  attr_reader :holders, :task_manager, :master, :caretaker

  def initialize
    super
    @master       = MasterAccount.new
    @caretaker    = Caretaker.instance
    @holders      = HoldersController.instance
    @task_manager = Rufus::Scheduler.new
  end

  def open(type, with:)
    account = create type, (holders.find with)
    add account
    init_yearly_interest_for account
    AccountSuccessMessage.new(account)
  rescue ItemExist => message
    message
  end

  def deposit(amount, into:)
    account = find into
    account.deposit (convert_to_int amount)
    DepositSuccessMessage.new(amount)
  rescue ItemExist, GreaterThanZero => message
    message
  end

  def withdraw(amount, from:)
    account = find from
    init_limit_reset_for account unless account.breached?
    account.withdraw (convert_to_int amount)
    WithdrawSuccessMessage.new(amount)
  rescue ItemExist, OverLimit, InsufficientFunds, GreaterThanZero => message
    message
  end

  def get_balance_of(id)
    account = find id
    BalanceMessage.new(account)
  rescue ItemExist => message
    message
  end

  def transfer(amount, from:, to:)
    amount = convert_to_int amount
    donar = find from
    caretaker.add donar.get_state
    donar.withdraw amount
    (find to).deposit amount
    init_limit_reset_for donar unless donar.breached?
    TransferSuccessMessage.new(amount)
  rescue ItemExist, OverLimit, InsufficientFunds, GreaterThanZero => message
    caretaker.restore donar if donar
    message
  end

  def add_holder(id, to:)
    holder = holders.find id
    account = find to
    account.add_holder holder
    AddHolderSuccessMessage.new(holder, account)
  rescue ItemExist, HolderOnAccount => message
    message
  end

  def get_transactions_of(id)
    transactions = (find id).transactions
    TransactionsMessage.new(transactions)
  rescue ItemExist => message
    message
  end

  def get_accounts_of(id)
    holder = holders.find id
    accounts = store.select { |_, a| a.holders_include? holder }.values
    DisplayAccountsMessage.new(accounts)
  rescue ItemExist => message
    message
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
      account.reset_limit
    end
  end

  def create(type, holder)
    account_class = ACCOUNT_CLASSES[type]
    account_class.new(holder, current_id)
  end
end
