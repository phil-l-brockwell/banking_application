# Definition of DepositSuccessMessage Class
class DepositSuccessMessage < Message
  def initialize(amount)
    super
    @amount = '£' + '%.2f' % amount
    @main = ["#{@amount} deposited."]
  end
end
