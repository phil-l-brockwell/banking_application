require 'require_all'
require_all 'lib/accounts'
# Definition of Controller Class
class Controller
  attr_reader :name, :accounts, :account_id,
              :holders, :holder_id

  def initialize
    @account_id = 0
    @holder_id  = 0
    @accounts   = {}
    @holders    = {}
  end

  def open_account(type, holder)
    new_account = create_account(type, holder)
    add_account(new_account)
    increment_account_id
    new_account.id
  end

  def create_holder(name)
    new_holder = Holder.new(name, @holder_id)
    increment_holder_id
    @holders[new_holder.id] = new_holder
    new_holder.id
  end

  def deposit_into(account_id, amount)
    @accounts[account_id].deposit(amount)
  end

  def withdraw_from(account_id, amount)
    @accounts[account_id].withdraw(amount)
  end

  def transfer_between(donar_id, recipitent_id, amount)
    @accounts[donar_id].withdraw(amount)
    @accounts[recipitent_id].deposit(amount)
  end

  def pay_interest_on(account_id)
    @accounts[account_id].add_interest
  end

  def add_holder_to(account_id, new_holder)
    @accounts[account_id].add_holder(new_holder)
  end

  def get_transactions_of(account_id)
    @accounts[account_id].transactions
  end

  def get_accounts_of(holder)
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
