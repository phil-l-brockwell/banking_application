# Definition of Success Message Class
class SuccessMessage < BaseMessage
  def initialize(*)
    super
    @header = 'Transaction Successful.'
  end
end
