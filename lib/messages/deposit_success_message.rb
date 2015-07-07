# Definition of DepositSuccessMessage Class
class DepositSuccessMessage < SuccessMessage
  attr_reader :amount

  def initialize(amount)
    super
    @amount = amount
    @main = "£#{@amount} deposited."
  end
end
