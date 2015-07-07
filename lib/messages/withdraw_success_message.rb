# Definiton of Withdraw Success Message
class WithdrawSuccessMessage < SuccessMessage
  attr_accessor :amount

  def initialize(amount)
    super
    @amount = amount
    @main = "£#{@amount} withdrawn."
  end
end
