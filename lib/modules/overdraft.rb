# Definition of Overdrafts module
module Overdrafts
  def show_overdraft(id)
    boundary.render OverdraftStatusMessage.new(find id)
  rescue ItemExistError => message
    boundary.render message
  end

  def activate_overdraft(id, amount)
    account = find id
    account.overdraft_on = true
    account.overdraft = amount
    boundary.render OverdraftStatusMessage.new(account)
  rescue ItemExistError => message
    boundary.render message
  end

  def deactivate_overdraft(id)
    account = find id
    account.overdraft_on = false
    account.overdraft = 0
    boundary.render OverdraftStatusMessage.new(account)
  rescue ItemExistError => message
    boundary.render message
  end
end
