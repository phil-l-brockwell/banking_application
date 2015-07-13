module Interest
  attr_reader :account

  def initialize
    super
    @account = MasterAccount.new
  end

  def calculate_interest_on(account)
    interest = account.balance * account.interest_rate
    deduct_interest interest
    interest
  end

  private

  def deduct_interest(amount)
    @account.withdraw amount
  end
end
