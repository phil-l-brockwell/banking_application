class Account

  attr_reader :balance, :holders, :interest_rate, :account_number

  def initialize(holder)
    @balance = 0.00
    @holders = [holder]
  end

  def add(holder)
    @holders << holder
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    fail 'The withdrawal amount exceeds your current balance!' if amount > @balance
    @balance -= amount
  end
end
