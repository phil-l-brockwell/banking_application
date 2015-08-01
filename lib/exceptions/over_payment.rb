# Definition of over payment class
class OverPayment < BaseException
  # will be called when a loan payment exceeds the total amount outstanding
  def initialize
    super
    @main = 'The payment amount entered is greater than the outstanding balance.'
  end
end
