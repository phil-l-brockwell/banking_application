# Definition of Error Message Class
class AccountErrorMessage < BaseMessage

  attr_accessor :incorrect_holder_id

  def initialize(incorrect_holder_id)
    super
    @incorrect_holder_id = incorrect_holder_id
    @output = "Transaction Error. Holder ID: #{incorrect_holder_id} does not exist."
  end
end
