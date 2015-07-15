# Definition of Item Exist Exception
class ItemExist < BaseException

  def initialize
    super
    @main = 'One or more of the ID numbers entered was not recognised.'
  end
end
