# Definiton of Invalid Account Message
class InvalidAccountMessage < ErrorMessage
  attr_accessor :invalid_account_id

  def initialize(invalid_account_id)
    super
    @invalid_account_id = invalid_account_id
    @main = ["Account ID: #{@invalid_account_id} does not exist.",
             'Try again']
  end
end
