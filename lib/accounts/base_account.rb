# Definition of Base Account Class
class BaseAccount
  attr_reader :balance, :type, :transactions,
              :id, :main_holder

  def initialize(*)
    @balance = 0.00
    @transactions = []
  end

  def deposit(amount)
    @balance += amount
    new_transaction = Transaction.new(:deposit, amount)
    add_transaction new_transaction
  end

  def withdraw(amount)
    @balance -= amount
    new_transaction = Transaction.new(:withdrawal, amount)
    add_transaction new_transaction
  end

  def add_transaction(transaction)
    @transactions << transaction
  end
end
