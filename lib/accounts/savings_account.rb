# Definition of Savings Account Class
class SavingsAccount < CustomerAccount
  def initialize(holder, account_number)
    super
    @type = :Savings
  end
end
