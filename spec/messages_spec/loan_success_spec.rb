require 'messages/loan_success'

describe 'LoanSuccessMessage' do
  context 'when initialised' do
    let(:loan) { double :loan, id: 6, outstanding: 10, repayment_date: '1/1/1' }
    let(:test_message) { LoanSuccessMessage.new(loan) }

    it 'knows the loan id' do
      expect(test_message.loan_id).to eq(6)
    end

    it 'knows the outstanding amount' do
      expect(test_message.outstanding).to eq(10)
    end

    it 'knows the repayment_date' do
      expect(test_message.repayment_date).to eq('1/1/1')
    end

    it 'has the correct main text' do
      expect(test_message.main)
        .to eq(['New Loan created. ID number is: 6.',
                'Total outstanding is £10.',
                'Repayment Date is 1/1/1'])
    end
  end
end
