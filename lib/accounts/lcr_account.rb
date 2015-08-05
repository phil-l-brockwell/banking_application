# Definition of LCR Account Class
class LCRAccount < CustomerAccount
  # inherits from customer account
  # this account type will have no overdraft facilities
  def initialize(holder, id)
    # defines initialize method, accepts holder and id
    super
    # calls super initialize method
    @type = :LCR
    # sets type
    @overdraft = 0.00
  end

  # overides overdraft method
  def activate_overdraft(*)
    # raises an exception if this method is called
    fail OverdraftDenied
  end
end
