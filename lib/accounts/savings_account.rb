# Definition of Savings Account Class
class SavingsAccount < BaseAccount
  def initialize(holder, account_number)
    super
    @type = :Savings
    @limit = 300
  end
end
