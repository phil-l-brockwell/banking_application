# Definition of Negative Amount exception
class GreaterThanZero < BaseException
  def initialize
    super
    @main = 'Amounts, Rates and Term must be positive and greater than zero.'
  end
end
