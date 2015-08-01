# Definition of Base Account Class
# This is the class that all account types will inherit from. 
class BaseAccount
  # Declare readable attributes. This is the equivalent of getter methods in Java or other languages.
  # By defining them here, these can be call using .attribute. For Example account.balance will return 0.00
  attr_reader :balance, :type, :transactions,
              :id, :main_holder, :holders

  # The initialize method, this method is called when .new is called on the class
  # The asterix indicates that any number of args can be passed, this will be explained further in its inheritants
  def initialize(*)
    # Set account balance to 0
    @balance = 0.00
    # Set transactions to an empty array
    @transactions = []
  end

  # method used to output the balance as a string with two decimal places and a pound sign
  def output_balance
    '£' + '%.2f' % @balance
  end

  # method used to output the overdraft as a string with two decimal places and a pound sign
  def output_overdraft
    '£' + '%.2f' % @overdraft    
  end

  # defines deposit method
  def deposit(amount)
    @balance += amount
    # creates a transaction and adds it to the transactions array
    add_transaction Transaction.new(:deposit, amount)
  end

  # defines withdrawal method
  def withdraw(amount)
    @balance -= amount
    # creates a transaction and adds it to the transactions array
    add_transaction Transaction.new(:withdrawal, amount)
  end

  def add_transaction(transaction)
    @transactions << transaction
  end

  # creates a memento and passes itself as an arg to the initialize method, then returns the memento
  def get_state
    Memento.new(self)
  end

  # method used to restore a previous state. takes a memento as an arg and uses its attributes to revert
  def restore_state(memento)
    @balance = memento.balance
    @daily_limit = memento.daily_limit
    @transactions = memento.transactions
  end

  # method to check if the account contains a specific amount, will be used for withdrawals
  def contains?(amount)
    @balance + @overdraft >= amount
  end

  # method used to check if a holder exists on an account. will be used when searching and adding holders
  def holders_include?(holder)
    @main_holder == holder || holders.value?(holder)
  end
end
