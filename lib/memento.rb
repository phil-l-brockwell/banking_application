# Definition of Memento Class
# the memento class will be used to store the past details of an account
# memento will be initialised with an account and are responsible for storing the relevant parts of that account
# will be used to rollback transactions
class Memento
  attr_reader :balance, :id, :daily_limit, :transactions
  # defines readable attributes, equivalent of getter methods in java
  # memento.balance will return the balance attribute

  def initialize(account)
    # initialised with an account
    @balance = account.balance
    # sets balance to accounts current balance
    @id = account.id
    # sets id to accounts id
    @daily_limit = account.daily_limit
    # sets daily limit to accounts current daily limit
    @transactions = account.transactions
    # sets transactions to accounts current transactions
  end
end
