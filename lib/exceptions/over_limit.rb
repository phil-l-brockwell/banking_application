# Definiton of Over Limit exception
# raised when an amount passed is greater than what the accounts limit allows
class OverLimit < BaseException
  def initialize
    super
    @main = 'This Transaction exceeds the daily limit and cannot be proccessed.'
  end
end
