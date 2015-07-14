# Definition of Memento Class
class Memento
  attr_reader :balance, :id, :daily_limit, :transactions

  def initialize(account)
    @balance = account.balance
    @id = account.id
    @daily_limit = account.daily_limit
    @transactions = account.transactions
  end
end
