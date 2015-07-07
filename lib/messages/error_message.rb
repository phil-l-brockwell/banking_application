# Definition of Error Message Class
class ErrorMessage < BaseMessage
  def initialize(*)
    super
    @header = 'Transaction Error.'
  end
end
