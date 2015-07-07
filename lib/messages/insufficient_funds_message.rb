class InsufficientFundsMessage < BaseMessage

  attr_accessor :account_id

  def initialize(account)
    @account_id = account.id
    @output = "Transaction Error. Account ID: #{@account_id} has insufficient funds."
  end
end
