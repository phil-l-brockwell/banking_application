# Definition of Savings Account Class
class SavingsAccount < CustomerAccount
  # inherits from customer account
  def initialize(holder, account_number)
    # called when .new is called on the class, takes holder and account_number args
    super
    # calls super classes initialize method
    @type = :Savings
    # sets type
  end
end
