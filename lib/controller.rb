# Definition of Controller Class
class Controller
  attr_reader :name, :accounts
  attr_accessor :account_number

  def initialize
    @account_number = 0
    @accounts       = {}
  end

  def increment_account_number
    @account_number += 1
  end

  def add_account(new_account)
    @accounts[new_account.account_number] = new_account
  end

  def deposit_into(account, amount)
    account.deposit(amount)
  end

  def create_account(type, holder)
    increment_account_number
    CurrentAccount.new(holder, @account_number)
  end
end
