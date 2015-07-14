module Interest

  def pay_interest_on(account)
    interest = (account.balance * account.interest_rate).abs
    if account.overdrawn?
      account.withdraw interest
      master.deposit interest
    else
      master.withdraw interest
      account.deposit interest
    end
  end

end
