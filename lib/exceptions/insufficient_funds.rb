# Definition of Insufficient funds exception
class InsufficientFunds < BaseException
  def output
    ['Transaction Error',
     'This account has Insufficient funds',
     'Please Try again.']
  end
end
