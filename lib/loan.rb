require 'date'
# Definition of Loan Class
class Loan
  attr_accessor :amount_borrowed, :holder, :rate,
                :term, :repayment_date, :transactions,
                :outstanding, :id

  def initialize(options = {}, id)
    fail NegativeAmount unless options[:borrowed] > 0
    @id = id
    @amount_borrowed = options[:borrowed]
    @holder = options[:holder]
    @term = options[:term]
    @rate = options[:rate]
    @repayment_date = (DateTime.now >> (12 * @term)).strftime('%a %d %b %Y')
    @transactions = []
    @outstanding = @amount_borrowed + (amount_borrowed * rate)
  end

  def make_payment(amount)
    fail NegativeAmount unless amount > 0
    @outstanding -= amount
    new_transaction = Transaction.new(:loan_payment, amount)
    add_transaction new_transaction
  end

  def output_outstanding
    '£' + '%.2f' % @outstanding
  end

  private

  def add_transaction(transaction)
    @transactions << transaction
  end
end
