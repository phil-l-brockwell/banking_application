# Definition of Current Account Class
class CurrentAccount < CustomerAccount

  def initialize(holder, id)
    super
    @type = :Current
  end
end
