require 'singleton'
# singleton is a ruby library containing the singleton module
require_relative '../modules/controller_item_store'
# controller_item_store module is required
# Definition of Holders Controller Class, this class will be responsible for creating and finding holders
class HoldersController
  include ControllerItemStore, Singleton
  # includes modules

  # create holder method
  def create(name)
    # takes name as an arg
    holder = Holder.new(name, current_id)
    # creates a new holder, passing name and current_id, current_id is a method that returns the current id
    # assigns to local variable
    add holder
    # add holder to storage hash
    NewHolderSuccessMessage.new(holder)
    # returns success message
  end
end
