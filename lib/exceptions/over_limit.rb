# Definiton of Over Limit exception
class OverLimit < BaseException
  def output
    ['Transaction Error',
     'This Transaction exceeds the daily limit and cannot be proccessed',
     'Please Try again.']
  end
end
