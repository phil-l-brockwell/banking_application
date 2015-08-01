# Definition of Holder on account exception
# raised when adding a holder to an account
class HolderOnAccount < BaseException
  def initialize
    super
    @main = 'The Holder Selected already exists on the selected account.'
  end
end
