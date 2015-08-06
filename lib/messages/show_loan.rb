# Definition of ShowLoanMessage Class
# returned when a message is successfully created
class ShowLoanMessage < Message
  attr_reader :outstanding, :holder_name,
              :repayment_date, :transactions

  def initialize(loan)
    super
    @holder_name = loan.holder.name
    @transactions = loan.transactions
    @repayment_date = loan.repayment_date
    @outstanding = loan.output_outstanding
    @main = loan_details + transaction_details
    # combines loan details and transaction details
  end

  def output
    @main.unshift(@header)
  end

  private

  # builds the loan details
  def loan_details
    ["Holder Name: #{@holder_name}",
     "Final Repayment Date: #{@repayment_date}",
     "Outstanding Amount: #{@outstanding}"]
  end

  # builds the transactions details
  def transaction_details
    a = @transactions.map.each_with_index.map do |t, index|
      "#{index + 1}. Date: #{t.date}, Amount: #{t.output_amount}"
    end
    # map returns a copy of array with code inside block, sets to a
    a.unshift('Transactions:')
    # add text to front off array
  end
end
