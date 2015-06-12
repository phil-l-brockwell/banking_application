# Definition of Base Account Class
class BaseAccount
  attr_reader :balance, :holders, :account_number, :transactions
  attr_accessor :interest_rate

  def initialize(holder)
    @balance = 0.00
    @holders = [holder]
    @transactions = []
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
end
