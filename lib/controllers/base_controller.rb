class BaseController

  attr_reader :store, :id

  def initialize
    @store = {}
    @id = 1
  end

  def item_exist?(item_id)
    store[item_id]
  end

  private

  def increment_id
    @id += 1
  end

  def add_item(item)
    store[item.id] = item
  end
end
