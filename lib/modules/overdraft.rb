# Definition of Overdrafts module
module Overdrafts
  def show_overdraft(id)
    OverdraftStatusMessage.new(find id)
  rescue ItemExistError => message
    message
  end

  def activate_overdraft(id, amount)
    account = find id
    account.overdraft_on = true
    account.overdraft = amount
    OverdraftStatusMessage.new(account)
  rescue ItemExistError => message
    message
  end

  def deactivate_overdraft(id)
    account = find id
    account.overdraft_on = false
    account.overdraft = 0
    OverdraftStatusMessage.new(account)
  rescue ItemExistError => message
    message
  end
end
