# Definition of Business Account Class
class BusinessAccount < BaseAccount
  def initialize(holder, account_number)
    super
    @type = :business
  end
end
