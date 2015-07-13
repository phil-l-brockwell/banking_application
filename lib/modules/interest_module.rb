module Interest
  attr_reader :master_account

  def initialize
    @master_account = MasterAccount.new
  end

  def calculate_interest_on(account)
    interest = account.balance * account.interest_rate
    deduct_interest interest
    interest
  end

  def deduct_interest(amount)
    puts @master_account
    @master_account.withdraw amount
  end
end
