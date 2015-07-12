module Overdrafts
  def show_overdraft(id)
    account = exist? id
    boundary.render OverdraftStatusMessage.new(account)
  end

  def activate_overdraft(id, amount)
    account = exist? id
    account.overdraft_on = true
    account.overdraft = amount
    boundary.render OverdraftStatusMessage.new(account)
  end

  def deactivate_overdraft(id)
    account = exist? id
    account.overdraft_on = false
    account.overdraft = 0
    boundary.render OverdraftStatusMessage.new(account)
  end
end
