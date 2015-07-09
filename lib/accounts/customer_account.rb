# Definition of Customer Account Class
class CustomerAccount < BaseAccount
  attr_accessor :interest_rate, :holders, :daily_limit

  LIMIT = 300

  def initialize(holder, id)
    super
    @main_holder = holder
    @id = id
    @holders = {}
    @interest_rate = 0.1
    @daily_limit = LIMIT
  end

  def withdraw(amount)
    @balance -= amount
    deduct_from_daily_limit amount
    new_transaction = Transaction.new(:withdrawal, amount)
    add_transaction new_transaction
  end

  def add_holder(holder)
    @holders[holder.id] = holder
  end

  def reset_limit
    @daily_limit = LIMIT
  end

  def under_limit?
    @daily_limit < LIMIT
  end

  private

  def deduct_from_daily_limit(amount)
    @daily_limit -= amount
  end
end
