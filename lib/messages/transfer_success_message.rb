# Defintion of Transfer Success Message Class
class TransferSuccessMessage < SuccessMessage
  attr_reader :amount

  def initialize(amount)
    super
    @amount = amount
    @main = ["£#{@amount} transferred."]
  end
end
