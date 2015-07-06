class BalanceMessage < BaseMessage

  attr_accessor :balance, :account_id

  def initialize(account)
    @balance = account.balance
    @account_id = account.id
    @output = "Transaction Successful. Balance of Account ID: #{@account_id} is £#{balance}"
  end
end
