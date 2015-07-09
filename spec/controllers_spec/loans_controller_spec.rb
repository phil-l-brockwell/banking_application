require 'controllers/loans_controller'

describe 'LoansController' do
  let(:holder)    { double :holder           }
  let(:loan_ctrl) { LoansController.instance }

  context 'when creating a loan' do
    it 'adds it to the store' do
      options = { holder: holder, borrowed: 100_00, term: 5, rate: 1 }
      expect { loan_ctrl.create_loan(options) }
        .to change { loan_ctrl.store.length }.by(1)
    end

    it 'returns a success message with the new loan id' do
      new_loan_id = loan_ctrl.id
      options = { holder: holder, borrowed: 100_00, term: 5, rate: 1 }
      message = loan_ctrl.create_loan(options)
      expect(message.loan_id).to eq(new_loan_id)
    end

    it 'creates a loan with the correct details' do
      options = { holder: holder, borrowed: 100_00, term: 5, rate: 1 }
      message = loan_ctrl.create_loan(options)
      id = message.loan_id
      loan = loan_ctrl.store[id]
      expect(loan.holder).to eq(holder)
      expect(loan.amount_borrowed).to eq(100_00)
      expect(loan.term).to eq(5)
      expect(loan.rate).to eq(1)
    end
  end

  context 'when making payments' do
    let(:loan) { double :loan, id: 0, outstanding: 1 }

    it 'the loans receives the payment' do
      loan_ctrl.add(loan)
      expect(loan).to receive(:make_payment).with(500)
      loan_ctrl.pay(500, off: 0)
    end
  end
end
