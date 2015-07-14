# Definition of Customer Account Class
class CustomerAccount < BaseAccount
  attr_reader :interest_rate, :holders, :daily_limit
  attr_accessor :overdraft, :overdraft_on

  LIMIT = 300

  def initialize(holder, id)
    super
    @main_holder   = holder
    @id            = id
    @holders       = {}
    @interest_rate = 0.1
    @daily_limit   = LIMIT
    @overdraft_on  = false
    @overdraft     = 0
  end

  def get_state
    Memento.new(self)
  end

  def restore_state(memento)
    @balance = memento.balance
    @daily_limit = memento.daily_limit
    @transactions = memento.transactions
  end

  def output_balance
    '£' + '%.2f' % @balance
  end

  def withdraw(amount)
    fail InsufficientFunds unless contains? amount
    fail OverLimit unless limit_allow? amount
    @balance -= amount
    @daily_limit -= amount
    add_transaction Transaction.new(:withdrawal, amount)
  end

  def add_holder(holder)
    fail HolderOnAccount if holders_include? holder
    @holders[holder.id] = holder
  end

  def overdrawn?
    @balance < 0
  end

  def reset_limit
    @daily_limit = LIMIT
  end

  def breached?
    @daily_limit < LIMIT
  end

  def contains?(amount)
    @balance + @overdraft >= amount
  end

  def limit_allow?(amount)
    daily_limit >= amount
  end

  def holders_include?(holder)
    main_holder == holder || holders.value?(holder)
  end
end
