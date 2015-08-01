# Definition of Loan Success Message Class
# returned when a loan is created successfully
class LoanSuccessMessage < Message
  def initialize(loan)
    super
    @main = ["New Loan created. ID number is: #{loan.id}.",
             "Total outstanding is #{loan.output_outstanding}.",
             "Repayment Date is #{loan.repayment_date}"]  
  end
end
