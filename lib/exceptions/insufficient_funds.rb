# Definition of Insufficient funds exception
# raised when a withdrawal amount exceeds available balance
class InsufficientFunds < BaseException
  def initialize
    super
    @main = 'This account has Insufficient funds.'
  end
end
