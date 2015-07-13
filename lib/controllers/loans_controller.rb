require 'singleton'
require_relative '../modules/controller_item_store'
# Definition of Loan Controller Class
class LoansController
  include Singleton
  include ControllerItemStore

  def create_loan(options)
    loan = Loan.new(options, current_id)
    add loan
    boundary.render LoanSuccessMessage.new(loan)
  end

  def show(id)
    loan = exist? id
    boundary.render ShowLoanMessage.new(loan)
  end

  def pay(amount, off:)
    loan = exist? off
    loan.make_payment amount
    boundary.render LoanPaidMessage.new(loan)
  end
end
