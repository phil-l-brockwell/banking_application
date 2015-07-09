require 'controllers/loan_controller'

describe 'LoanController' do
  let(:holder)    { double :holder     }
  let(:loan_ctrl) { LoanController.new }

  context 'when creating a loan' do

    it 'adds it to the store' do
      options = { holder: holder, borrowed: 10000, term: 5, rate: 1 }
      expect { loan_ctrl.create_loan(options) }
        .to change { loan_ctrl.store.length }.by(1)
    end

    it 'returns a success message with the new loan id' do
      new_loan_id = loan_ctrl.id
      options = { holder: holder, borrowed: 10000, term: 5, rate: 1 }
      message = loan_ctrl.create_loan(options)
      expect(message.loan_id).to eq(new_loan_id)
    end

    it 'creates a loan with the correct details' do
      options = { holder: holder, borrowed: 10000, term: 5, rate: 1 }
      message = loan_ctrl.create_loan(options)
      id = message.loan_id
      loan = loan_ctrl.store[id]
      expect(loan.holder).to eq(holder)
      expect(loan.amount_borrowed).to eq(10000)
      expect(loan.term).to eq(5)
      expect(loan.rate).to eq(1)
    end
  end
end
