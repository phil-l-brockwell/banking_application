# Definition of IR Account Class
class IRAccount < CustomerAccount
  def initialize(holder, account_number)
    super
    @type = :IR
  end
end
