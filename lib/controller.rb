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

  def open_account(holder)
    new_account = CurrentAccount.new(holder, @account_number)
    add_account(new_account)
    increment_account_number
  end

  private

  def add_account(new_account)
    @accounts[new_account.account_number] = new_account
  end
end
