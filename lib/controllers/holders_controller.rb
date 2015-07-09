require 'singleton'
require_relative 'controller_item_store'
# Definition of Holders Controller Class
class HoldersController
  include ControllerItemStore
  include Singleton

  def create(name)
    new_holder = Holder.new(name, current_id)
    add new_holder
    NewHolderSuccessMessage.new(new_holder)
  end
end
