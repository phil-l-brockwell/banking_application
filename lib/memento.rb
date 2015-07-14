# Definition of Memento Class
class Memento
  attr_reader :balance, :account_id

  def initialize(balance, account_id)
    @balance = balance
    @account_id = account_id
  end
end
