class HighInterestAccount < BaseAccount

  def initialize(holder, id)
    super
    @type = :HighInterest
    @interest_rate = 0.2
  end
end
