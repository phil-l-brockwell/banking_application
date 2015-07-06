# Definition of Error Message Class
class InvalidHolderMessage < BaseMessage

  attr_accessor :invalid_holder_id

  def initialize(invalid_holder_id)
    super
    @invalid_holder_id = invalid_holder_id
    @output = "Transaction Error. Holder ID: #{invalid_holder_id} does not exist."
  end
end
