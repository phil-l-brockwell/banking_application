require_relative 'controller_item_store'
# Definition of Loan Controller Class
class LoanController
  include ControllerItemStore

  def create_loan(options)
    new_loan = Loan.new(options, current_id)
    add new_loan
    LoanSuccessMessage.new(new_loan)
  end
end
