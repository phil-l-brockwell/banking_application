class WithdrawSuccessMessage < BaseMessage
  attr_accessor :amount

  def initialize(amount)
    @amount = amount
    @output = "Transaction Successful. £#{@amount} withdrawn."
  end
end
