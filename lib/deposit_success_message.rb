class DepositSuccessMessage < BaseMessage

  attr_reader :amount

  def initialize(amount)
    @amount = amount
    @output = "Transaction Successful. £#{@amount} deposited."
  end
end
