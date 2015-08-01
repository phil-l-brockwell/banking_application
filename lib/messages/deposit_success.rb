# Definition of DepositSuccessMessage Class
# returned when a deposit is successfully made
class DepositSuccessMessage < Message
  def initialize(amount)
    super
    @amount = '£' + '%.2f' % amount
    @main = ["#{@amount} deposited."]
  end
end
