require 'date'
# Definition of Loan Class
class Loan
  attr_accessor :amount_borrowed, :holder, :rate,
                :term, :repayment_date, :transactions,
                :outstanding, :id

  def initialize(options = {}, id)
    @id = id
    @amount_borrowed = options[:borrowed]
    @holder = options[:holder]
    @term = options[:term]
    @rate = options[:rate]
    @repayment_date = DateTime.now >> (12 * @term)
    @transactions = []
    @outstanding = @amount_borrowed + (amount_borrowed * rate)
  end

  def make_payment(amount)
    @outstanding -= amount
    new_transaction = Transaction.new(:loan_payment, amount)
    add_transaction new_transaction
  end

  private

  def add_transaction(transaction)
    @transactions << transaction
  end
end
