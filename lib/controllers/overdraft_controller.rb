require 'singleton'

class OverdraftController
  include Singleton

  attr_reader :accounts, :boundary

  def initialize
    @accounts = AccountsController.instance
  end

  def boundary
    @boundary ||= Boundary.instance
  end

  def show(id)
    account = accounts.exist? id
    boundary.render OverdraftStatusMessage.new(account)
  end

  def activate(id, amount)
    account = accounts.exist? id
    account.overdraft_on = true
    account.overdraft = amount
    boundary.render OverdraftStatusMessage.new(account)
  end

  def deactivate(id)
    account = accounts.exist? id
    account.overdraft_on = false
    account.overdraft = 0
    boundary.render OverdraftStatusMessage.new(account)
  end
end
