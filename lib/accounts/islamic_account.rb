# require 'exceptions/overdraft_denied'
# Defintion of Islamic Account Class
class IslamicAccount < CustomerAccount
  def initialize(holder, id)
    super
    @type = :Islamic
    @interest_rate = 0
  end

  def overdraft_on
    fail OverdraftDenied
  end
end
