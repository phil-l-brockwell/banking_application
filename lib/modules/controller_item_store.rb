# Definition of Controller Item Store module
# this module will be included by the holders, accounts and loans controller
# it will include all common functionality, such as adding items to a hash
# retrieving objects from a hash
# converting string to integers, or float values
# tracking ids
# raising some exceptions
module ControllerItemStore
  # defines readable attributes, equivalent to java reader methods
  attr_reader :store, :id

  # initialize method
  def initialize
    @store = {}
    # sets store to an empty object, this will be used by the controller to store its respective items
    @id = 1
    # initializes id as 1
  end

  # method to find an item in the store
  def find(id)
    # converts id to an integer
    id = id.to_i
    # raises an exception if the item is not contained in the store
    fail ItemExist unless store[id]
    # returns the item
    store[id]
  end

  # method to add an item to the store
  def add(item)
    store[item.id] = item
    # saves the item, using its id as its key and the actual item as the value
  end

  # converts a string to an integer, used for converting numerical amounts into integers
  def convert_to_int(string)
    fail GreaterThanZero unless (greater_than_zero string.to_i)
    # raises exception if the converted string is zero or minus
    string.to_i
    # returns the integer
  end

  # converts a string to a float, used for converting loan rates to float
  def convert_to_float(string)
    fail GreaterThanZero unless (greater_than_zero string.to_f)
    # raises an exception if the converted amount is zero or minus
    string.to_f
    # returns the float
  end

  # private area
  private

  # current id method, will return the next available id and increment the counter
  def current_id
    new_id = @id
    # sets id to local variable
    @id += 1
    # increments id
    new_id
    # returns new_id
  end

  # method to check if an amount is greater than zero
  def greater_than_zero(amount)
    amount > 0
  end
end
