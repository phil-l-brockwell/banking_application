require 'messages/loan_success'

describe 'LoanSuccessMessage' do
  context 'when initialised' do
    let(:loan) { double :loan, id: 6, output_outstanding: '£10.00', repayment_date: '1/1/1' }
    let(:test_message) { LoanSuccessMessage.new(loan) }

    it 'has the correct main text' do
      expect(test_message.main)
        .to eq(['New Loan created. ID number is: 6.',
                'Total outstanding is £10.00.',
                'Repayment Date is 1/1/1'])
    end
  end
end
