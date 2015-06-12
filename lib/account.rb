class Account

  attr_reader :balance, :holders

  def initialize
    @balance = 0.00
    @holders = []
  end

  def add(holder)
    @holders << holder
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    @balance -= amount
  end
end
