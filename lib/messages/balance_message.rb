# Defintion of Balance Message Class
class BalanceMessage < SuccessMessage
  attr_reader :balance, :account_id

  def initialize(account)
    super
    @balance = account.output_balance
    @account_id = account.id
    @main = ["Balance of Account ID: #{@account_id} is #{balance}"]
  end
end
