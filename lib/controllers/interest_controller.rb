class InterestController

  attr_reader :account

  def initialize
    @account = MasterAccount.new
  end

  def calculate_interest_on(account)
    interest = account.balance * account.interest_rate
    deduct_interest interest
    interest
  end

  def deduct_interest(amount)
    @account.withdraw 500
  end
end