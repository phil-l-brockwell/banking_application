require 'loan'

describe 'Loan' do
  context 'when initialised' do
    let(:test_holder) { double :holder }

    def create_loan
      options = { holder: test_holder, borrowed: 1000, term: 2, rate: 2 }
      loan = Loan.new(options)
    end
    
    it 'knows how much was borrowed' do
      loan = create_loan
      expect(loan.amount_borrowed).to eq(1000)
    end

    it 'has an interest rate' do
      loan = create_loan
      expect(loan.rate).to eq(2)
    end

    it 'has a holder' do
      loan = create_loan
      expect(loan.holder).to eq(test_holder)
    end

    it 'has a term' do
      loan = create_loan
      expect(loan.term).to eq(2)
    end

    it 'calculates the repayment date' do
      loan = create_loan
      today = DateTime.now
      expect(loan.repayment_date.year - today.year).to be(2)
    end

    it 'has an empty payments array' do
      loan = create_loan
      expect(loan.payments).to eq([])
    end
  end
end
