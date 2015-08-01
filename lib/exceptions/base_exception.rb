# Definition of Base Exception class
# all other exception messages will inherit from this class
# this allows the header, footer and colour to be consistent throughout
# also an output method is defined. each inheritant is then only responsible for its main text
class BaseException < Exception
  # inherits from rubys exception class
  attr_reader :colour
  # makes colour a readable attribute. same as a getter method in java
  # calling exception.colour will return :red

  # initialize method, can take any number of args
  def initialize(*)
    super
    # calls super initialize method
    @colour = :red
    # sets colour to red
    @header = 'Transaction Error.'
    # sets header text
    @footer = 'All Incomplete Operations have been Rolled back. Try again.'
    # sets footer text
  end

  # defines output method, can be called by boundary or html page to output the full text of the message
  def output
    [@header, @main, @footer].join(' ')
    # puts all parts of message into an array and joins them into a string with a blank space between each element
  end
end
