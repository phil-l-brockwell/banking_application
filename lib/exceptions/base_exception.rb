# Definition of Base Exception class
class BaseException < Exception
  attr_reader :colour

  def initialize(*)
    @colour = :red
  end
end
