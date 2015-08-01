# Definition of Current Account Class
class CurrentAccount < CustomerAccount
  # inherits from customer account
  def initialize(holder, id)
    # passes a holder and id to initialize method
    super
    # calls super classes initialize method
    @type = :Current
    # sets account type, this will be used by controller
  end
end
