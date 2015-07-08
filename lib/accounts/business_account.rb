# Definition of Business Account Class
class BusinessAccount < BaseAccount

  LIMIT = 500

  def initialize(holder, account_number)
    super
    @type = :Business
    @limit = LIMIT
  end
end
