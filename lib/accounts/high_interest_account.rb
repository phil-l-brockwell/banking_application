# Definition of High Interest Account Class
class HighInterestAccount < CustomerAccount
  # inherits from customer account
  def initialize(holder, id)
    # initialize method, called when .new is called on the Class
    super
    # calls super initialize method
    @type = :HighInterest
    # sets type
    @interest_rate = 0.2
    # sets interest rate
  end
end
