# Definition of Transaction Class
class Transaction
  attr_reader :type, :date, :amount

  def initialize(type, amount)
    @type = type
    @amount = amount
    @date = Time.now.strftime('%a %d %b %Y')
  end

  def output_amount
    '£' + '%.2f' % @amount
  end
end
