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

  def open_account(type, holder)
    new_account = create_account(type, holder)
    add_account(new_account)
    increment_account_number
  end

  private

  def add_account(new_account)
    @accounts[new_account.account_number] = new_account
  end

  def create_account(type, holder)
    return CurrentAccount.new(holder, @account_number)  if type == :current
    return SavingsAccount.new(holder, @account_number)  if type == :savings
    return BusinessAccount.new(holder, @account_number) if type == :business
    return IRAccount.new(holder, @account_number)       if type == :ir
    return SMBAccount.new(holder, @account_number)      if type == :smb
    return StudentAccount.new(holder, @account_number)  if type == :student
  end
end
