# Defintion of Islamic Account Class
class IslamicAccount < CustomerAccount

  def initialize(holder, id)
    super
    @type = :Islamic
    @interest_rate = nil
  end
end
