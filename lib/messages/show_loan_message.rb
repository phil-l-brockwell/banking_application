# Definition of ShowLoanMessage Class
class ShowLoanMessage < SuccessMessage
  attr_reader :outstanding, :holder_name,
              :repayment_date, :transactions

  def initialize(loan)
    super
    @holder_name = loan.holder.name
    @transactions = loan.transactions
    @repayment_date = loan.repayment_date
    @outstanding = loan.outstanding
    @main = loan_details + transaction_details
  end

  def loan_details
    ["Holder Name: #{@holder_name}",
     "Final Repayment Date: #{@repayment_date}",
     "Outstanding Amount: £#{@outstanding}"]
  end

  def transaction_details
    a = @transactions.map.each_with_index.map do |t, index|
      "#{index + 1}. Date: #{t.date}, Amount: £#{t.amount}"
    end
    a.unshift('Transactions:')
  end
end
