require 'singleton'
# singleton is a ruby library containing the singleton module
require_relative '../modules/controller_item_store'
# controller_item_store module is required
require_relative '../modules/overdraft'
# overdraft module is required
require_relative '../modules/interest'
# interest module is required
# Definition of Controller Class
# responsibilities of this class are to execute functions on accounts and return messages to the boundary
# all functions include a normal flow of events and a rescue block. if exceptions are raised they are caught and returned as a message to the boundary
# after executing any rollback code. 
# this allows the controller method to show the flow of each method without the need for multiple convoluted if statements
class AccountsController
  include ControllerItemStore, Overdrafts, Singleton, Interest
  # includes various modules

  attr_reader :holders, :task_manager, :caretaker, :types
  # sets readable attributes, equivalent to writing a getter method in java or other languages
  # controller.holders (or just holders, inside this class) will now return an instance of the holders controller
  # these are mainly used during testing

  def initialize
    # initialize method
    ControllerItemStore.instance_method(:initialize).bind(self).call
    # calls initialize method from controller item store module
    Interest.instance_method(:initialize).bind(self).call
    # calls initialize method from interest module
    # using super in this method would only initialize the first of the two modules
    # so each module is initialized separately
    @caretaker    = Caretaker.instance
    # reference to the instance of the caretaker class, which manages mementos
    @holders      = HoldersController.instance
    # reference to the instance of the holders controller class, which manages holders
    @task_manager = Rufus::Scheduler.new
    # reference to the task manager class which manages tasks
    @types = { :Current      => CurrentAccount,
               :Savings      => SavingsAccount,
               :Business     => BusinessAccount,
               :Ir           => IRAccount,
               :Smb          => SMBAccount,
               :Student      => StudentAccount,
               :Highinterest => HighInterestAccount,
               :Islamic      => IslamicAccount,
               :Private      => PrivateAccount,
               :Lcr          => LCRAccount          }
    # hash used to store all of the available account types
    # keys are stored as symbols, symbols are similar to string but without all the editing methods that can be called on them
    # limiting memory requirements
    # each hash is a symbol of its name and its value is a constant which will be used to call .new on
  end

  # open account method
  def open(type, with:)
    # accepts two args, type = account type, with: holder_id, can be written 'open :Current, with: 4'
    account = create type, (@holders.find with)
    # gets the holder from the holders controller, calls the create method and passes it the holder and type
    # sets it to an account variable
    add account
    # adds account to its own storage hash
    init_yearly_interest_for account unless account.type == :Islamic
    # initializes a yearly interest payment, unless account is islamic
    AccountSuccessMessage.new(account)
    # creates and returns message
  rescue ItemExist, UnrecognisedAccountType => message
    # catches exceptions and saves them to a message, then executes code inside block
    message
    # returns message
  end

  # deposit method
  def deposit(amount, into:)
    # accepts two args, amount = deposit amount and into: = account id
    # can be written deposit 500, into 3
    account = find into
    # finds account and assigns it to account local variable
    account.deposit(convert_to_float amount)
    # converts the amount to an integer then passes it as an arg to accounts deposit method
    DepositSuccessMessage.new(amount)
    # creates and returns message
  rescue ItemExist, GreaterThanZero => message
    # catches exceptions and saves them to a message, then executes code inside block
    message
    # returns message
  end

  # withdraw method
  def withdraw(amount, from:)
    # accepts two args, amount = withdrawal amount and from: = account id
    account = find from
    # finds account and assigns it to local variable
    init_limit_reset_for account unless account.breached?
    # initialises limit reset for account unless account is breached and a limit reset has already been initialised
    account.withdraw(convert_to_float amount)
    # converts amount to an integer from string and passes as arg to accounts withdraw method
    WithdrawSuccessMessage.new(amount)
    # creates and returns message
  rescue ItemExist, OverLimit, InsufficientFunds, GreaterThanZero => message
    # catches exceptions and saves them to a message, then executes code inside block
    message
    # returns message
  end

  # get balance method
  def get_balance_of(id)
    # accepts one arg of account id
    account = find id
    # finds account and saves to local variable
    BalanceMessage.new(account)
    # creates and returns message
  rescue ItemExist => message
    # catches exceptions and saves them to a message, then executes code inside block
    message
    # returns message
  end

  # transfer method
  def transfer(amount, from:, to:)
    # accepts three args, amount = amount, from: = donar account, to: = recipitent account
    # can be written transfer 500, from: 1, to: 54
    amount = convert_to_float amount
    # converts amount to integer and saves to account local variable
    donar = find from
    # finds donar account and saves in local variable
    @caretaker.add donar.get_state
    # calls get_state on donar account which returns a momento, then passess momento as an arg to the caretakers add method
    init_limit_reset_for donar unless donar.breached?
    # initialises a limit reset for donar account unless one has already been initialised
    donar.withdraw amount
    # withdraws amount from donar amount
    (find to).deposit amount
    # finds the recipitent account and calls .deposit on it passing amount as an arg
    TransferSuccessMessage.new(amount)
    # creates and returns message
  rescue ItemExist, OverLimit, InsufficientFunds, GreaterThanZero => message
    # catches exceptions and saves them to a message, then executes code inside block
    @caretaker.restore donar if donar
    # calls caretakers restore method, passing the donar account if it exists, this rollsback the withdrawal from donar account
    message
    # returns message
  end

  # method to add a holder to an account
  def add_holder(id, to:)
    # takes two args, id = new holder id, to: = account id to be added to
    # can be written add holder 1, to: 3
    holder = @holders.find id
    # calls find method on holders controller and passes holder id, assigns to local variable
    account = find to
    # finds account and assigns to local variable
    account.add_holder holder
    # creates and returns message
    AddHolderSuccessMessage.new(holder, account)
    # creates message and returns it
  rescue ItemExist, HolderOnAccount => message
    # catches exceptions and saves them to a message, then executes code inside block
    message
    # returns exception as message
  end

  # get transactions of an account method
  def get_transactions_of(id)
    # takes one arg of the account id
    transactions = (find id).transactions
    # find the account and sets its transactions equal to the transactions local variable
    TransactionsMessage.new(transactions)
    # creates and returns a transactions message, message is responsible for its own output of the transactions array
  rescue ItemExist => message
    # catches exceptions and saves them to a message, then executes code inside block
    message
    # returns exception as message
  end

  # method to get accounts of a holder
  def get_accounts_of(id)
    # method takes holders id as an arg
    holder = @holders.find id
    # calls find method on holders controller and passes id as arg, assigns result to holder local variable
    accounts = store.select { |_, a| a.holders_include? holder }.values
    # selects all accounts from store hash that include holder and return them as an array and save to accounts local variable 
    DisplayAccountsMessage.new(accounts)
    # creates success message, passing accounts array, message is responsible for outputting itself
    # returns message
  rescue ItemExist => message
    # catches exceptions and saves them to a message, then executes code inside block
    message
    # returns message
  end

  # private area, these methods can only be called from inside the class
  # this increases readability and encapsulation
  private

  # method to initialize yearly interest payments on an account
  def init_yearly_interest_for(account)
    @task_manager.every '1y' do
      pay_interest_on account
    end
  end

  # method to initialize a limit reset for a given account
  def init_limit_reset_for(account)
    @task_manager.in '1d' do
      account.reset_limit
    end
  end

  # method to normalise a string
  # capitalize makes the first letter a capital
  # gsub is a regular expression to remove and white space or special chars
  # to_sym converts the string to a symbol for comparison purposes
  def normalise(string)
    string.capitalize.gsub(/\s+/, '').to_sym
  end

  # method to encapsulate creating an account
  def create(type, holder)
    # takes a type and holder args
    type = normalise type
    # normalises type
    fail UnrecognisedAccountType unless types[type]
    # tries to find account type, if it fails, raises an exception
    account_class = types[type]
    # sets account constant equal to account_class local variable
    account_class.new(holder, current_id)
    # calls .new on account class, passes holder and current_id method which returns the current id
  end
end
