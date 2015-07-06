class InvalidAccountMessage < BaseMessage

  attr_accessor :invalid_account_id

  def initialize(invalid_account_id)
    @invalid_account_id = invalid_account_id
    @output = "Transaction Error. Account ID: #{@invalid_account_id} does not exist."
  end
end
