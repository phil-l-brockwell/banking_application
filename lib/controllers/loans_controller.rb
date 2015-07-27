require 'singleton'
require_relative '../modules/controller_item_store'
# Definition of Loan Controller Class
class LoansController
  include Singleton, ControllerItemStore

  attr_reader :holders

  def initialize
    super
    @holders = HoldersController.instance
  end

  def create_loan(id, amount, term, rate)
    options = { holder: (holders.find id),   borrowed: (convert_to_int amount),
                term: (convert_to_int term), rate: (convert_to_float rate)      }
    loan = Loan.new(options, current_id)
    add loan
    LoanSuccessMessage.new(loan)
  rescue ItemExist, GreaterThanZero => message
    message
  end

  def show(id)
    ShowLoanMessage.new(find id)
  rescue ItemExist => message
    message
  end

  def pay(amount, off:)
    loan = find off
    loan.make_payment (convert_to_int amount)
    LoanPaidMessage.new(loan)
  rescue ItemExist, GreaterThanZero => message
    message
  end
end
