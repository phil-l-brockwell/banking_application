require 'messages/loan_paid'

describe 'LoanPaidMessage' do
  context 'when initialised' do
    let(:loan)         { double :loan, id: 1, output_outstanding: '£200.00' }
    let(:test_message) { LoanPaidMessage.new(loan)             }

    it 'has the correct main text' do
      expect(test_message.main)
        .to eq(['Payment made to Loan ID: 1.',
                'Outstanding balance now £200.00'])
    end
  end
end
