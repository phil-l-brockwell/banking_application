require 'base_message'

class AccountSuccessMessage < BaseMessage

  attr_reader :new_account_id

  def initialize(new_account)
    super
    @new_account_id = new_account.id
    @output = "Transaction Successful. New Account created. ID number is: #{@new_account_id}"
  end
end
