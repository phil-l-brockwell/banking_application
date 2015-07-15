require 'singleton'
require_relative '../modules/controller_item_store'
# Definition of Loan Controller Class
class LoansController
  include Singleton
  include ControllerItemStore

  attr_reader :holders

  def initialize
    super
    @holders = HoldersController.instance
  end

  def create_loan(id, options)
    options[:holder] = holders.find id
    loan = Loan.new(options, current_id)
    add loan
    LoanSuccessMessage.new(loan)
  rescue ItemExist => message
    message
  end

  def show(id)
    ShowLoanMessage.new(find id)
  rescue ItemExist => message
    message
  end

  def pay(amount, off:)
    loan = find off
    loan.make_payment amount
    LoanPaidMessage.new(loan)
  rescue ItemExist => message
    message
  end
end
