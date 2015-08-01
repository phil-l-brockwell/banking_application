# Definition of Item Exist Exception
# raised when an holder, loan or account id is not recognised
class ItemExist < BaseException
  def initialize
    super
    @main = 'One or more of the ID numbers entered was not recognised.'
  end
end
