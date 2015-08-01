require 'date'
# requires date library for calculating dates
# Definition of Loan Class
# this class will be responsbile for storing loan data
# it is initialisd with a set of options and then calculates other variables
# such as the outstanding amount and the repayment date
# the loan knows how much it has outstanding and will raise exception if it is overpaid
class Loan
  attr_reader :amount_borrowed, :holder, :rate,
              :term, :repayment_date, :transactions,
              :outstanding, :id
  # defines readable attributes

  def initialize(options = {}, id)
    # initializes with a set of options and an id
    @id = id
    # sets id
    @amount_borrowed = options[:borrowed]
    # gets borrowed value from options hash and assign to class variable
    @holder = options[:holder]
    # gets holder value from options hash and assigns to class variable
    @term = options[:term]
    # gets term from options hash and assigns to class variable
    @rate = options[:rate]
    # gets rate from options hash and assigns to class variable
    @repayment_date = (DateTime.now >> (12 * @term)).strftime('%a %d %b %Y')
    # calculates repayment date and converts to string
    @transactions = []
    # sets transactions to an empty array
    @outstanding = @amount_borrowed + (amount_borrowed * rate)
    # calculates interest and adds to borrowed amount to give total outstanding
  end

  # method used to make a loan payment
  def make_payment(amount)
    # takes an amount as an arg
    fail OverPayment if amount > @outstanding
    # raises an exception if the amount is greater than current outstanding balance
    @outstanding -= amount
    add_transaction Transaction.new(:loan_payment, amount)
    # creates new transaction and adds to transactions array
  end

  # method to output outstanding amount
  def output_outstanding
    '£' + '%.2f' % @outstanding
  end

  # private area
  private

  # method to add transaction
  def add_transaction(transaction)
    @transactions << transaction
  end
end
