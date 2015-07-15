# Definition of Holder on account exception
class HolderOnAccount < BaseException
  def initialize
    super
    @main = 'The Holder Selected already exists on the selected account.'
  end
end
