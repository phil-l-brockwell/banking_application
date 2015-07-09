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
end
