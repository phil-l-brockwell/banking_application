# Definition of Success Message Class
# all success messages will inherit from this class
# sets the header and colour
class Message
  attr_reader :output, :header, :main, :colour

  def initialize(*)
    @header = 'Transaction Successful.'
    @colour = :green
  end

  # defines output method, can be called by boundary or inside html/erb
  def output
    # adds header to beginning of main array then joins all elements with a blank space
    (@main.unshift(@header)).join(' ')
  end
end
