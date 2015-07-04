require 'require_all'
require_all 'lib/accounts'
# Definition of Controller Class
class Controller
  attr_reader :name, :accounts, :account_id, :holders, :holder_id

  def initialize
    @account_id = 0
    @holder_id  = 0
    @accounts   = {}
    @holders    = {}
  end

  def open_account(type, with:)
    holder = holder_exist? with
    new_account = create_account(type, holder)
    add_account new_account
    increment_account_id
    new_account.id
  end

  def create_holder(name)
    new_holder = Holder.new(name, @holder_id)
    increment_holder_id
    @holders[new_holder.id] = new_holder
    new_holder.id
  end

  def deposit(amount, into:)
    account = account_exist? into
    account.deposit amount
  end

  def withdraw(amount, into:)
    account = account_exist? into
    account.withdraw amount
  end

  def get_balance_of(account_id)
    account = account_exist? account_id
    account.balance
  end

  def transfer(amount, from:, to:)
    donar = account_exist? from
    recipitent = account_exist? to
    donar.withdraw amount
    recipitent.deposit amount
  end

  def pay_interest_on(account_id)
    account = account_exist? account_id
    account.add_interest
  end

  def add_holder(id, to_account:)
    new_holder = holder_exist? id
    account = account_exist? to_account
    account.add_holder new_holder
  end

  def get_transactions_of(account_id)
    account = account_exist? account_id
    account.transactions
  end

  def get_accounts_of(holder_id)
    holder = holder_exist? holder_id
    @accounts.select { |_, account| account.main_holder.id == holder.id }.values
  end

  private

  ACCOUNT_CLASSES = { current:  CurrentAccount,
                      savings:  SavingsAccount,
                      business: BusinessAccount,
                      ir:       IRAccount,
                      smb:      SMBAccount,
                      student:  StudentAccount }

  def add_account(new_account)
    @accounts[new_account.id] = new_account
  end

  def holder_exist?(holder_id)
    fail "Holder id #{holder_id} does not exist!" unless @holders[holder_id]
    @holders[holder_id]
  end

  def account_exist?(account_id)
    fail "Account id #{account_id} does not exist!" unless @accounts[account_id]
    @accounts[account_id]
  end

  def create_account(type, holder)
    account_class = ACCOUNT_CLASSES[type]
    account_class.new(holder, @account_id)
  end

  def increment_account_id
    @account_id += 1
  end

  def increment_holder_id
    @holder_id += 1
  end
end
