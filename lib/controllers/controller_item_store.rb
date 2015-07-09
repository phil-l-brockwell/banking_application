# Definition of Controller Item Store module
module ControllerItemStore
  attr_reader :store, :id

  def initialize
    @store = {}
    @id = 1
  end

  def exist?(id)
    store[id]
  end

  private

  def current_id
    new_id = @id
    @id += 1
    new_id
  end

  def add(item)
    store[item.id] = item
  end
end
