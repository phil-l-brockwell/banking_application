# Definition of Business Account Class
class BusinessAccount < CustomerAccount
  # inherits from customer account
  LIMIT = 500
  # has a constant limit of 500, this will be used to reset the limit

  # initialize method, takes a holder and an id
  def initialize(holder, id)
    super
    # calls the super initialize method of customer account
    @type = :Business
    # sets type to business, this will be used by the accounts controller
    @daily_limit = LIMIT
    # sets the daily limit to LIMIT constant. this will be used to restrict withdrawals
  end
end
