# Definition of Base Message Class
class BaseMessage
  attr_reader :output, :header, :main

  def initialize(*)
    @header
  end

  def output
    "#{@header} #{@main}"
  end
end
