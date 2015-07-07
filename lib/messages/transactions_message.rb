class TransactionsMessage < SuccessMessage

  attr_reader :transactions, :main

  def initialize(transactions)
    super
    @transactions = transactions
    @main = build_main
  end

  def output
    @main.unshift(@header)
  end

  def build_main
    @transactions.each_with_index.map do |transaction, index| 
      "#{index + 1}. Type: #{transaction.type}, Date: #{transaction.date}, Amount: £#{transaction.amount}" 
    end
  end
end
