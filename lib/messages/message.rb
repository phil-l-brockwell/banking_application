# Definition of Success Message Class
class Message
  attr_reader :output, :header, :main, :colour

  def initialize(*)
    @header = 'Transaction Successful.'
    @colour = :green
  end

  def output
    (@main.unshift(@header)).join(' ')
  end
end
