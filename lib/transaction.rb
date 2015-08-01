# Definition of Transaction Class
# this class will be responsible for holding data of an accounts transactions
# a transaction will be initialised after a succesful transaction has taken place
class Transaction
  attr_reader :type, :date, :amount
  # defines readable attributes, equivalent of getter methods in java
  # transaction.amount will return the amount attribute

  # initializes with a type and amount
  def initialize(type, amount)
    @type = type
    # type will be deposit, withdrawal or loan payment
    @amount = amount
    # sets amount
    @date = Time.now.strftime('%a %d %b %Y')
    # sets time/date
    # .now gets current date/time
    # .strftime converts the date into a string
  end

  # method to output the transaction amount
  def output_amount
    '£' + '%.2f' % @amount
  end
end
