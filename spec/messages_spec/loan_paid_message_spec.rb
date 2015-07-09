require 'messages/loan_paid_message'

describe 'LoanPaidMessage' do

  context 'when initialised' do
    let(:loan)         { double :loan, id: 1, outstanding: 200 }
    let(:test_message) { LoanPaidMessage.new(loan)             }

    it 'knows the loan id' do
      expect(test_message.loan_id).to eq(1)
    end

    it 'knows the outstanding amount' do
      expect(test_message.outstanding).to eq(200)
    end

    it 'has the correct main text' do
      expect(test_message.main).to eq(['Payment made to Loan ID: 1. Outstanding balance is now £200'])
    end
  end
end
