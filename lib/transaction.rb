class Transaction

  attr_reader :type, :date, :amount

  def initialize(type, amount)
    @type = type
    @amount = amount
    @date = Time.now
  end
end
