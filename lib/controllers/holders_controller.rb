class HoldersController

  attr_accessor :holders, :holder_id

  def initialize
    @holders = {}
    @holder_id = 1
  end

  def create_holder(name)
    new_holder = Holder.new(name, @holder_id)
    increment_holder_id
    @holders[new_holder.id] = new_holder
    NewHolderSuccessMessage.new(new_holder)
  end

  def holder_exist?(holder_id)
    holders[holder_id]
  end

  private

  def increment_holder_id
    @holder_id += 1
  end
end
