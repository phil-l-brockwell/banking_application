class OverdraftDenied < BaseException
  def initialize
    super
    @main = 'The selected account has no Overdraft Facility.'
  end
end
