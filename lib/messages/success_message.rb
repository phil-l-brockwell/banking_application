# Definition of Success Message Class
class SuccessMessage
  attr_reader :output, :header, :main

  def initialize(*)
    @header = 'Transaction Successful.'
  end

  def output
    @main.unshift(@header)
  end
end
