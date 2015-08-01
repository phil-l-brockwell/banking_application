# Definition of overdraft denied exception
# raised when when a muslim/lcr accounts overdraft methods is called
class OverdraftDenied < BaseException
  def initialize
    super
    @main = 'The selected account has no Overdraft Facility.'
  end
end
