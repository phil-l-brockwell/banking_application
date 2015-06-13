# Definition of Base Account Class
class BaseAccount
  attr_reader :balance, :holders, :account_number,
              :transactions, :type, :interest_rate

  def initialize(holder, account_number)
    @balance = 0.00
    @holders = [holder]
    @transactions = []
    @account_number = account_number
  end

  def add_holder(holder)
    @holders << holder
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    fail 'The withdrawal amount exceeds current balance!' if amount > @balance
    @balance -= amount
  end

  def add_interest
    @balance += balance * interest_rate
  end

  def add_transaction(transaction)
    @transactions << transaction
  end

  def change_interest_rate_to(interest_rate)
    @interest_rate = interest_rate
  end
end
