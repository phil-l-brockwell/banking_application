class ItemExistError < Exception
  def output
    ['Transaction Error',
     'One or more of the ID numbers entered was not recognised',
     'Please Try again.']
  end
end

# Definition of Controller Item Store module
module ControllerItemStore
  attr_reader :store, :id, :boundary

  def initialize
    @store = {}
    @id = 1
  end

  def find(id)
    raise ItemExistError unless store[id]
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
