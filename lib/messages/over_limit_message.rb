# Definition of Over Limit Message Class
class OverLimitMessage < ErrorMessage
  attr_accessor :account_id

  def initialize(account)
    super
    @account_id = account.id
    @main = ["Account ID: #{@account_id} has reached its daily withdrawal limit."]
  end
end
