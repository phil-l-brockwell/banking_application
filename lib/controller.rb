# Definition of Controller Class
class Controller
  attr_reader :name, :accounts, :holders
  attr_accessor :account_number, :holder_number

  def initialize
    @account_number = 0
    @holder_number  = 0
    @accounts       = {}
    @holders        = {}
  end

  def increment_account_number
    @account_number += 1
  end

  def increment_holder_number
    @holder_number += 1
  end

  def add_holder(new_holder)
    @holders[new_holder.id] = new_holder
    increment_holder_number
  end

  def add_account(new_account)
    @accounts[new_account.account_number] = new_account
    increment_account_number
  end

  def deposit_into(account, amount)
    account.deposit(amount)
  end
end
