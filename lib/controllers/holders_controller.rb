class HoldersController

  attr_reader :store, :id

  def initialize
    @store = {}
    @id = 1
  end

  def create_holder(name)
    new_holder = Holder.new(name, @id)
    increment_id
    store[new_holder.id] = new_holder
    NewHolderSuccessMessage.new(new_holder)
  end

  def holder_exist?(holder_id)
    store[holder_id]
  end

  private

  def increment_id
    @id += 1
  end
end
