# Definition of Item Exist Exception
class ItemExistError < BaseException
  def output
    ['Transaction Error',
     'One or more of the ID numbers entered was not recognised',
     'Please Try again.']
  end
end
