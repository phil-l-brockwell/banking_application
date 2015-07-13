# Definition of Item Exist Exception
class ItemExist < BaseException
  def output
    ['Transaction Error',
     'One or more of the ID numbers entered was not recognised',
     'Please Try again.']
  end
end
