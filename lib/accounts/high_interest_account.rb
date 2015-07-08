# Definition of High Interest Account Class
class HighInterestAccount < CustomerAccount
  def initialize(holder, id)
    super
    @type = :HighInterest
    @interest_rate = 0.2
  end
end
