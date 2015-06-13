# Definition of IR Account Class
class IRAccount < BaseAccount
  def initialize(holder, account_number)
    super
    @type = :ir
  end
end

