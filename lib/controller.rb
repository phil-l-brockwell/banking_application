require 'require_all'
require_all 'lib/accounts'
# Definition of Controller Class
class Controller
  attr_reader :name, :accounts, :account_number

  def initialize
    @account_number = 0
    @accounts       = {}
  end

  def open_account(type, holder)
    new_account = create_account(type, holder)
    add_account(new_account)
    increment_account_number
  end

  def deposit_into(account_number, amount)
    @accounts[account_number].deposit(amount)
  end

  def withdraw_from(account_number, amount)
    @accounts[account_number].withdraw(amount)
  end

  private

  ACCOUNT_CLASSES = { current:  CurrentAccount,
                      savings:  SavingsAccount,
                      business: BusinessAccount,
                      ir:       IRAccount,
                      smb:      SMBAccount,
                      student:  StudentAccount }

  def add_account(new_account)
    @accounts[new_account.account_number] = new_account
  end

  def create_account(type, holder)
    account_class = ACCOUNT_CLASSES[type]
    account_class.new(holder, @account_number)
  end

  def increment_account_number
    @account_number += 1
  end
end
