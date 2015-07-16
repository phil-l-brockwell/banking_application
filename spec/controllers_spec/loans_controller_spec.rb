require 'controllers/loans_controller'

describe 'LoansController' do
  let(:loan_ctrl) { LoansController.instance }

  context 'when making payments' do
    let(:loan) { double :loan, id: 0, output_outstanding: 1 }

    it 'the loans receives the payment' do
      loan_ctrl.add(loan)
      expect(loan).to receive(:make_payment).with(500)
      loan_ctrl.pay(500, off: 0)
    end
  end
end
