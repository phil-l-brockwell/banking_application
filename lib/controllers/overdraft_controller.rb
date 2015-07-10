class OverDraftController
  attr_reader :accounts

  def initialize
    @accounts = AccountsController.instance
  end

  def activate(id, amount)
    account = accounts.exist? id
    account.overdraft_on = true
    account.overdraft = amount
  end

  def deactivate(id)
    account.overdraft_on = false
    account.overdraft = 0
  end
end
