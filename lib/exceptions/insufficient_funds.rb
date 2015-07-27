# Definition of Insufficient funds exception
class InsufficientFunds < BaseException
  def initialize
    super
    @main = 'This account has Insufficient funds.'
  end
end
