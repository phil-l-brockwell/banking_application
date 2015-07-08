# Defintion of Islamic Account Class
class IslamicAccount < CustomerAccount

  def initialize(holder, id)
    super
    @type = :Islamic
    @interest_rate = 0
  end
end
