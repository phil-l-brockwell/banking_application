require 'singleton'

class OverdraftController
  include Singleton

  attr_reader :accounts

  def initialize
    @accounts = AccountsController.instance
  end

  def show(id)
    account = accounts.exist? id
    OverdraftStatusMessage.new(account)
  end

  def activate(id, amount)
    account = accounts.exist? id
    account.overdraft_on = true
    account.overdraft = amount
    OverdraftStatusMessage.new(account)
  end

  def deactivate(id)
    account = accounts.exist? id
    account.overdraft_on = false
    account.overdraft = 0
    OverdraftStatusMessage.new(account)
  end
end
