# Definition of LoanPaidMessage Class
class LoanPaidMessage < Message
  def initialize(loan)
    super
    @main = ["Payment made to Loan ID: #{loan.id}.",
             "Outstanding balance now #{loan.output_outstanding}"]
  end
end
