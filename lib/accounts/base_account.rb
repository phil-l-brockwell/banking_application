# Definition of Base Account Class
class BaseAccount
  attr_reader :balance, :main_holder, :holders, :id,
              :transactions, :type, :interest_rate, :limit

  LIMIT = 300

  def initialize(holder, id)
    @balance = 0.00
    @main_holder = holder
    @holders = {}
    @transactions = []
    @id = id
    @interest_rate = 0.1
    @limit = 300
  end

  def add_holder(holder)
    @holders[holder.id] = holder
  end

  def deposit(amount)
    @balance += amount
    new_transaction = Transaction.new(:deposit, amount)
    add_transaction new_transaction
  end

  def withdraw(amount)
    @balance -= amount
    deduct_from_limit amount
    new_transaction = Transaction.new(:withdrawal, amount)
    add_transaction new_transaction
  end

  def add_interest
    @balance += balance * interest_rate
  end

  def add_transaction(transaction)
    @transactions << transaction
  end

  def reset_limit
    @limit = LIMIT
  end

  private

  def deduct_from_limit(amount)
    @limit -= amount
  end
end
