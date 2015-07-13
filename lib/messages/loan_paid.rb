# Definition of LoanPaidMessage Class
class LoanPaidMessage < Message
  attr_reader :loan_id, :outstanding

  def initialize(loan)
    super
    @loan_id = loan.id
    @outstanding = loan.outstanding
    @main = ["Payment made to Loan ID: #{@loan_id}.",
             "Outstanding balance now £#{@outstanding}"]
  end
end
