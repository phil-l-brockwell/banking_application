# Definition of Transactions Message Class
class TransactionsMessage < SuccessMessage
  attr_reader :transactions, :main

  def initialize(transactions)
    super
    @transactions = transactions
    @main = build_main
  end

  def build_main
    @transactions.each_with_index.map do |t, index|
      "#{index + 1}. Type: #{t.type}, Date: #{t.date}, Amount: £#{t.amount}"
    end
  end
end
