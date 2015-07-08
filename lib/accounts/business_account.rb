# Definition of Business Account Class
class BusinessAccount < CustomerAccount

  LIMIT = 500

  def initialize(holder, id)
    super
    @type = :Business
    @daily_limit = LIMIT
  end
end
