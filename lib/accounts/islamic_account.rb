# Defintion of Islamic Account Class
class IslamicAccount < CustomerAccount
  # inherits from customer account
  # islamic accounts will have no overdraft facilities
  def initialize(holder, id)
    # initialize method, accepts a holder and id arg
    super
    # calls super initialize method
    @type = :Islamic
    # sets type
    @overdraft = 0.00
    # sets overdraft to 0
  end

  # overides overdraft method
  def overdraft_on
    # raises an exception if this method is called
    fail OverdraftDenied
  end
end
