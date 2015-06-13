# Definition of Current Account Class
class CurrentAccount < BaseAccount
  def initialize(holder, account_number)
    super
    @type = :current
  end
end
