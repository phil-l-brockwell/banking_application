class BaseException < Exception

  attr_reader :red

  def initialize(*)
    @colour = :red
  end
end
