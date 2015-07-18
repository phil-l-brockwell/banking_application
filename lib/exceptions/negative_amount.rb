# Definition of Negative Amount exception
class NegativeAmount < BaseException
  def initialize
    super
    @main = 'Transactions Amount must be positive and greater than zero.'
  end
end
