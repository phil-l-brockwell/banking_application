# Definition of Insufficient Message Class
class InsufficientFundsMessage < ErrorMessage
  attr_accessor :account_id

  def initialize(account)
    super
    @account_id = account.id
    @main = ["Account ID: #{@account_id} has insufficient funds."]
  end
end
