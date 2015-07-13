# Definiton of Withdraw Success Message
class WithdrawSuccessMessage < SuccessMessage
  attr_reader :amount

  def initialize(amount)
    super
    @amount = amount
    @main = ["£#{@amount} withdrawn."]
  end
end
