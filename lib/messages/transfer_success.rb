# Defintion of Transfer Success Message Class
class TransferSuccessMessage < Message
  attr_reader :amount

  def initialize(amount)
    super
    @amount = '£' + '%.2f' % amount
    @main = ["#{@amount} transferred."]
  end
end
