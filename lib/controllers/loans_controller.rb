require 'singleton'
require_relative 'controller_item_store'
# Definition of Loan Controller Class
class LoansController
  include Singleton
  include ControllerItemStore

  def create_loan(options)
    loan = Loan.new(options, current_id)
    add loan
    LoanSuccessMessage.new(loan)
  end

  def show(id)
    loan = exist? id
    ShowLoanMessage.new(loan)
  end

  def pay(amount, off:)
    loan = exist? off
    loan.make_payment amount
    LoanPaidMessage.new(loan)
  end
end
