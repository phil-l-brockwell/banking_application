# Definition of DepositSuccessMessage Class
class DepositSuccessMessage < Message
  attr_reader :amount

  def initialize(amount)
    super
    @amount = '£' + '%.2f' % amount
    @main = ["#{@amount} deposited."]
  end
end
