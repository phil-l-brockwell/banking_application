# Definition of InvalidLoanMessage Class
class InvalidLoanMessage < ErrorMessage
  attr_reader :id

  def initialize(id)
    super
    @id = id
    @main = ["Loan ID: #{id} does not exist.",
             'Try again']
  end
end
