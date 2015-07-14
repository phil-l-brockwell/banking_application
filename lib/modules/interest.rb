module Interest

  def pay_interest_on(account)
    interest = calculate_interest(account)
    if account.overdrawn?
      account.withdraw interest
      master.deposit interest
    else
      master.withdraw interest
      account.deposit interest
    end
  end

  private

  def calculate_interest(account)
    (account.balance * account.interest_rate).abs
  end
end
