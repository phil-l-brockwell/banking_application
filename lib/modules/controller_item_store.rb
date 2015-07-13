# Definition of Controller Item Store module
module ControllerItemStore
  attr_reader :store, :id, :boundary

  def initialize
    @store = {}
    @id = 1
  end

  def find(id)
    fail ItemExistError unless store[id]
    store[id]
  end

  def add(item)
    store[item.id] = item
  end

  private

  def current_id
    new_id = @id
    @id += 1
    new_id
  end

  def boundary
    @boundary ||= Boundary.instance
  end
end
