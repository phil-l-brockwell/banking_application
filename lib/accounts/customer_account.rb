# Definition of Customer Account Class
# This is the class that all customer accounts will inherit from.
# It has been implemented so that the master account will not have certain features, such as overdraft
class CustomerAccount < BaseAccount
  # inherits from base account
  attr_reader :interest_rate, :daily_limit, :overdraft_on, 
              :overdraft, :holders, :main_holder, :id
  # defines readable attributes. these attributes can now be read outside of the object.
  # equivalent to creating a getter method in java or other languages
  # so account.interest_rate will return 0.1

  LIMIT = 300
  # sets a limit constant to 300

  def initialize(holder, id)
    # passes a holder and an id
    super
    # calls super classes initialize method
    @main_holder   = holder
    # sets main holder equal to the holder that was passed to initialize
    # used to store the main holder of the account
    @id            = id
    # sets id to the id that was equal to the id that was passed to initialize
    # this hash will be used to store secondary holders on the account
    @holders       = {}
    # sets holders equal to an empty hash object, similar to a java hash map
    @interest_rate = 0.1
    # sets interest rate equal to 0.1, this will be used for calculating interest
    @daily_limit   = LIMIT
    # sets daily limit equal to the limit constant
    @overdraft_on  = false
    # overdraft defaults to off
    @overdraft     = 0.00
    # sets overdraft amount to zero
  end

  # method used to output the overdraft as a string with two decimal places and a pound sign
  def output_overdraft
    '£' + '%.2f' % @overdraft    
  end

  def activate_overdraft(amount)
    @overdraft_on = true
    @overdraft = amount
  end

  def switch_off_overdraft
    @overdraft_on = false
    @overdraft = 0
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

  # overrides withdrawal method defined in base account to incorporate error checking
  # the account will be responsible for tracking its own own limit, balance
  # and raising exceptions if these rules are breached
  # therefore the accounts main responsiblity is to ensure its integrity as an account
  def withdraw(amount)
    # raises an insufficient funds exception and retuns to the controller if the account does not have the amount passed
    fail InsufficientFunds unless contains? amount
    # raises an overlimit exception and returns to controller unless the accounts limit allows the amount to withdrawn
    fail OverLimit unless limit_allow? amount
    # by using conditional returns it eliminates the need for complex nested if/else/elsif statements
    # making the code more readable and simpler
    # if neither of the exceptions are raised the method will execute the following lines
    @balance -= amount
    # removes the amount from the daily limit
    @daily_limit -= amount
    # creates a transaction and adds it to the transaction array
    add_transaction Transaction.new(:withdrawal, amount)
  end

  # method to add secondary holders to account
  def add_holder(holder)
    # returns a holder on account exception if the holder is already on the account
    fail HolderOnAccount if holders_include? holder
    # adds the holder to the holders hash object
    @holders[holder.id] = holder
  end

    # method used to check if a holder exists on an account. will be used when searching and adding holders
  def holders_include?(holder)
    @main_holder == holder || holders.value?(holder)
  end

  # method to check if an account is in negative balance
  def overdrawn?
    @balance < 0
  end

  # method to reset the accounts daily limit
  def reset_limit
    @daily_limit = LIMIT
  end

  # method to check if the accounts limit is below the limit constant amount
  def breached?
    @daily_limit < LIMIT
  end

  private

  # method to check if an accounts limit has a specific amount
  def limit_allow?(amount)
    daily_limit >= amount
  end

  # method to check if the account contains a specific amount, will be used for withdrawals
  def contains?(amount)
    @balance + @overdraft >= amount
  end
end
