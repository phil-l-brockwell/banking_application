# Definition of Negative Amount exception
# raised when an amount passed is zero or a minus number
class GreaterThanZero < BaseException
  def initialize
    super
    @main = 'Amounts, Rates and Term must be positive and greater than zero.'
  end
end
