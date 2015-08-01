# Definition of LoanPaidMessage Class
# returned when a loan is paid
class LoanPaidMessage < Message
  def initialize(loan)
    super
    @main = ["Payment made to Loan ID: #{loan.id}.",
             "Outstanding balance now #{loan.output_outstanding}"]
  end
end
