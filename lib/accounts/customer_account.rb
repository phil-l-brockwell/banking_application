# Definition of Customer Account Class
class CustomerAccount < BaseAccount
  attr_reader :interest_rate, :holders, :daily_limit

  LIMIT = 300

  def initialize(holder, id)
    super
    @main_holder = holder
    @id = id
    @holders = {}
    @interest_rate = 0.1
    @daily_limit = LIMIT
  end

  def output_balance
    '£' + '%.2f' % @balance
  end

  def withdraw(amount)
    @balance -= amount
    @daily_limit -= amount
    add_transaction Transaction.new(:withdrawal, amount)
  end

  def add_holder(holder)
    @holders[holder.id] = holder
  end

  def reset_limit
    @daily_limit = LIMIT
  end

  def breached?
    @daily_limit < LIMIT
  end

  def contains?(amount)
    @balance >= amount
  end

  def limit_allow?(amount)
    daily_limit >= amount
  end

  def holder?(holder)
    main_holder == holder || holders.value?(holder)
  end
end
