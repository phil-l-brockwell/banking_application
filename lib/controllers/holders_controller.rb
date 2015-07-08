class HoldersController < BaseController

  def initialize
    super
  end

  def create_holder(name)
    new_holder = Holder.new(name, id)
    increment_id
    add_item new_holder
    NewHolderSuccessMessage.new(new_holder)
  end
end
