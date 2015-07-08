class MasterAccount < BaseAccount

  def initialize
    super
    @id = :master
    @main_holder = :master
    @balance = 1000000.00
    @type = :Master
  end

  def under_limit?
    false
  end
end
