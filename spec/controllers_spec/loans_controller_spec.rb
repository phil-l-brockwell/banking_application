require 'controllers/loans_controller'
# require the test subject

describe 'LoansController' do
  # sets up a test subject

  let(:loan_ctrl) { LoansController.instance }
  # creates an instance of the controller that we can use for testing

  context 'when making payments' do
    # tests in this block will test behaviour related to making payments

    let(:loan) { double :loan, id: 0, output_outstanding: 1 }
    # create a double of a loan to operate on

    it 'the loans receives the payment' do
      loan_ctrl.add(loan)
      expect(loan).to receive(:make_payment).with(500)
      # as the loan is a double we expect the loan to receive a message
      # as opposed to testing what the method will do
      loan_ctrl.pay(500, off: 0)
    end
  end
end
