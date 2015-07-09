# Definition of Loan Success Message Class
class LoanSuccessMessage < SuccessMessage
  attr_reader :loan_id, :outstanding, :repayment_date

  def initialize(loan)
    super
    @loan_id = loan.id
    @outstanding = loan.outstanding
    @repayment_date = loan.repayment_date
    @main = build_main
  end

  def build_main
    ["New Loan created. ID number is: #{@loan_id}.",
     "Total outstanding is £#{@outstanding}.",
     "Repayment Date is #{@repayment_date}"]
  end
end
