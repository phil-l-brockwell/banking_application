# Definition of Base Account Class
class BaseAccount
  attr_reader :balance, :type, :transactions,
              :id, :main_holder

  def initialize(*)
    @main_holder
    @id
    @holders
    @interest_rate
    @daily_limit
    @overdraft_on
    @overdraft
    @balance = 0.00
    @transactions = []
  end

  def output_balance
    '£' + '%.2f' % @balance
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

  def get_state
    Memento.new(self)
  end

  def restore_state(memento)
    @balance = memento.balance
    @daily_limit = memento.daily_limit
    @transactions = memento.transactions
  end

  def contains?(amount)
    @balance + @overdraft >= amount
  end

  def holders_include?(holder)
    main_holder == holder || holders.value?(holder)
  end
end
