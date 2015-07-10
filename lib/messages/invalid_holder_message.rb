# Definition of Error Message Class
class InvalidHolderMessage < ErrorMessage
  attr_accessor :invalid_holder_id

  def initialize(invalid_holder_id)
    super
    @invalid_holder_id = invalid_holder_id
    @main = ["Holder ID: #{invalid_holder_id} does not exist.",
             'Try again.']
  end
end
