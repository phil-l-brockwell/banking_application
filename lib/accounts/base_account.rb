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
    add_transaction Transaction.new(:deposit, amount)
  end

  def withdraw(amount)
    @balance -= amount
    add_transaction Transaction.new(:withdrawal, amount)
  end

  def add_transaction(transaction)
    @transactions << transaction
  end
end
