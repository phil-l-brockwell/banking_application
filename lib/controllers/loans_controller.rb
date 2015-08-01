require 'singleton'
# singleton is a ruby library containing the singleton module
require_relative '../modules/controller_item_store'
# controller_item_store module is required
# Definition of Loan Controller Class
class LoansController
  include Singleton, ControllerItemStore
  # includes various modules

  attr_reader :holders
  # sets readable attributes, equivalent of getter method in java or other languages

  def initialize
    super
    # calls super initialize method of controller item store
    @holders = HoldersController.instance
    # creates a reference to Holders controller instance
  end

  # create loan method
  def create_loan(id, amount, term, rate)
    # takes 4 args, id = holder id, amount = loan amount, term = length of time to borrow over
    # rate = interest rate
    options = { holder: (holders.find id),   borrowed: (convert_to_int amount),
                term: (convert_to_int term), rate: (convert_to_float rate)      }
    # creates a hash of key value pairs, converting each one to its respective value, to pass to loan class
    loan = Loan.new(options, current_id)
    # creates new loan, passing options hash and current id method, which returns the current id
    # assigns to local variable
    add loan
    # add loan to store
    LoanSuccessMessage.new(loan)
    # creates and returns loan success message, passing loan as an arg
  rescue ItemExist, GreaterThanZero => message
    # catches exceptions and saves to local message variable, then executes code in block
    message
    # returns message
  end

  # show loan method
  def show(id)
    # takes a loan id as an arg
    ShowLoanMessage.new(find id)
    # finds loan and passes to new loan message object
  rescue ItemExist => message
    # catches exceptions and saves to local message variable, then executes code in block
    message
    # returns message
  end

  # pay loan method
  def pay(amount, off:)
    # takes two args, amount = payment amount, off: = loan id
    # can be written, pay 100 off: 22
    loan = find off
    # finds loan and assigns to local variable
    loan.make_payment (convert_to_int amount)
    # converts amount to integer and passes as arg to loan make_payment method
    LoanPaidMessage.new(loan)
    # creates message and returns
  rescue ItemExist, GreaterThanZero, OverPayment => message
    # catches exceptions and saves to local message variable, then executes code in block
    message
    # returns message
  end
end
