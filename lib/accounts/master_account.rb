# Definition of Master Account Class
class MasterAccount < BaseAccount
  def initialize
    super
    @id = :master
    @main_holder = :master
    @balance = 100_000_0.00
    @type = :Master
  end

  def under_limit?
    false
  end

  def add_holder(*)
    nil
  end

  def overdrawn?
    false
  end

  def reset_limit
    nil
  end

  def breached?
    false
  end

  def limit_allow?(*)
    true
  end
end
