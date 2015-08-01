# Definition of Master Account Class
# the master account will be used to pay and receive the banks interest payments
# although core functionality will be the same as customer accounts, the account will not raise exceptions and has no limits
class MasterAccount < BaseAccount
  # inherits from base account
  def initialize
    # defines initialize method
    super
    # calls super initialize method
    @id = :master
    # sets id to master
    @main_holder = :master
    # sets main holder to master
    @balance = 100_000_0.00
    # sets balance to one million
    @type = :Master
    # sets type
  end

  # overides underlimit to always return false
  def under_limit?
    false
  end

  # overrides add holder method to do nothing and return nil
  def add_holder(*)
    nil
  end

  # overrides overdrawn method to always return false
  def overdrawn?
    false
  end

  # overrides reset_limit method to do nothing and return nil
  def reset_limit
    nil
  end

  # overrides breached method to always return false
  def breached?
    false
  end

  # overrides limit allow method to always return true
  def limit_allow?(*)
    true
  end
end
