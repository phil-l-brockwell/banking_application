# Definition of IR Account Class
class IRAccount < BaseAccount
  def initialize(holder, account_number)
    super
    @type = :IR
  end
end
