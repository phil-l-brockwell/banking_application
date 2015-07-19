# Definition of UnrecognisedAccountType exception
class UnrecognisedAccountType < BaseException
  def initialize
    super
    @main = 'Account Type not recognised.'
  end
end
