# Definition of Base Message Class
class BaseMessage
  attr_accessor :output, :header, :main

  def initialize(*)
  end

  def output
    @main.unshift(@header)
  end
end
