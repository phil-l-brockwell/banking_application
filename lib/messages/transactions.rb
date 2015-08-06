# Definition of Transactions Message Class
# returned when show transactions method is completed
class TransactionsMessage < Message
  attr_reader :transactions

  def initialize(transactions)
    super
    @transactions = transactions
    @main = build_main
  end

  def output
    @main.unshift(@header)
  end

  private

  # builds main body text
  def build_main
    # loops over each element in array, setting the transaction to t and index to index
    # performs relevant code
    @transactions.each_with_index.map do |t, index|
      "#{index + 1}. Type: #{t.type}, Date: #{t.date}, Amount: #{t.output_amount}"
    end
  end
end
