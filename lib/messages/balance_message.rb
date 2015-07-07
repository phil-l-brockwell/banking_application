# Defintion of Balance Message Class
class BalanceMessage < SuccessMessage
  attr_accessor :balance, :account_id

  def initialize(account)
    super
    @balance = account.balance
    @account_id = account.id
    @main = "Balance of Account ID: #{@account_id} is £#{balance}"
  end
end
