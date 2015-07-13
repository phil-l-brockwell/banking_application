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
    begin
      options[:holder] = holders.find id
      loan = Loan.new(options, current_id)
      add loan
      boundary.render LoanSuccessMessage.new(loan)
    rescue ItemExistError => message
      boundary.render message  
    end
  end

  def show(id)
    begin
      boundary.render ShowLoanMessage.new(find id)
    rescue ItemExistError => message
      boundary.render message
    end
  end

  def pay(amount, off:)
    begin
      loan = find off
      loan.make_payment amount
      boundary.render LoanPaidMessage.new(loan)
    rescue ItemExistError => message
      boundary.render message
    end
  end
end
