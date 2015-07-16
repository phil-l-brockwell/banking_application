# Definition of Base Exception class
class BaseException < Exception
  attr_reader :colour

  def initialize(*)
    super
    @colour = :red
    @header = 'Transaction Error.'
    @footer = 'All Incomplete Operations have been Rolled back. Try again.'
  end

  def output
    [@header, @main, @footer].join(' ')
  end
end
