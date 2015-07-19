# Definition of Overdrafts module
module Overdrafts
  def show_overdraft(id)
    OverdraftStatusMessage.new(find id)
  rescue ItemExist, OverdraftDenied => message
    message
  end

  def activate_overdraft(id, amount)
    account = find id
    account.overdraft_on = true
    account.overdraft = convert_to_int amount
    OverdraftStatusMessage.new(account)
  rescue ItemExist, OverdraftDenied, GreaterThanZero => message
    message
  end

  def deactivate_overdraft(id)
    account = find id
    account.overdraft_on = false
    account.overdraft = 0
    OverdraftStatusMessage.new(account)
  rescue ItemExist, OverdraftDenied => message
    message
  end
end
