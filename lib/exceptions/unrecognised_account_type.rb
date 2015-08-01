# Definition of UnrecognisedAccountType exception
# raised when an unrecognised account type is passed
class UnrecognisedAccountType < BaseException
  def initialize
    super
    @main = 'Account Type not recognised.'
  end
end
