# Definiton of Withdraw Success Message
# returned when withdrawal is successfully completed
class WithdrawSuccessMessage < Message
  attr_reader :amount

  def initialize(amount)
    super
    @amount = '£' + '%.2f' % amount
    @main = ["#{@amount} withdrawn."]
  end
end
