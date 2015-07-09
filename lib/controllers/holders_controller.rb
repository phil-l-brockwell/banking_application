require 'singleton'
require_relative 'controller_item_store'
# Definition of Holders Controller Class
class HoldersController
  include ControllerItemStore
  include Singleton

  def create(name)
    holder = Holder.new(name, current_id)
    add holder
    NewHolderSuccessMessage.new(holder)
  end
end
