# Definition of ShowLoanMessage Class
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
  end

  def loan_details
    ["Holder Name: #{@holder_name}",
     "Final Repayment Date: #{@repayment_date}",
     "Outstanding Amount: #{@outstanding}"]
  end

  def transaction_details
    a = @transactions.map.each_with_index.map do |t, index|
      "#{index + 1}. Date: #{t.date}, Amount: #{t.output_amount}"
    end
    a.unshift('Transactions:')
  end

  def output
    @main.unshift(@header)
  end
end
