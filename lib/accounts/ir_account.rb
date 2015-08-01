# Definition of IR Account Class
class IRAccount < CustomerAccount
  # inherits from customer account
  def initialize(holder, account_number)
    # initialize method
    super
    # calls super initialize method
    @type = :IR
    # sets type
  end
end
