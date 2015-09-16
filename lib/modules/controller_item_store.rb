# Definition of Controller Item Store module
module ControllerItemStore
  attr_reader :store, :id

  def initialize
    @store = {}
    @id = 1
  end

  def find(id)
    id = id.to_i
    fail ItemExist unless store[id]
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

  def greater_than_zero(amount)
    amount > 0
  end

  def convert_to_int(string)
    fail GreaterThanZero unless (greater_than_zero string.to_i)
    string.to_i
  end

  def convert_to_float(string)
    fail GreaterThanZero unless (greater_than_zero string.to_f)
    string.to_f
  end
end
