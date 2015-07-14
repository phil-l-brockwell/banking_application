require 'singleton'
# Definition of Caretaker Class
class Caretaker
  include ControllerItemStore, Singleton

  def restore(account)
    memento = find account.id
    account.restore_state memento
  end
end
