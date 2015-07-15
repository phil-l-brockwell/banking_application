# Definiton of Over Limit exception
class OverLimit < BaseException

  def initialize
    super
    @main = 'This Transaction exceeds the daily limit and cannot be proccessed.'
  end
end
