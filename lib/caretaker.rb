require_relative 'modules/controller_item_store'
# includes the controller item store to track and store mementos
require 'singleton'
# singleton is a ruby library containing the singleton module
# Definition of Caretaker Class
# this class will be used to handle memento for account rollback facilities
# it will store and retreive the mementos and restore accounts to their previous states
class Caretaker
  include ControllerItemStore, Singleton
  # includes various modules

  # method to restore an account to its past state
  def restore(account)
    # takes account as an arg
    memento = find account.id
    # uses the accounts id to find the relevant memento
    account.restore_state memento
    # calls the accounts restore method passing the memento as an arg
  end
end
