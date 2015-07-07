class IslamicAccount < BaseAccount

  undef_method :add_interest

  def initialize(holder, id)
    super
    @type = :Islamic
    @interest_rate = nil
  end
end
