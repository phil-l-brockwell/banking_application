require 'timecop'
require 'loan'

describe 'Loan' do
  let(:test_holder) { double :holder }

  def create_loan
    options = { holder: test_holder, borrowed: 1000, term: 2, rate: 2 }
    Loan.new(options, 5)
  end

  context 'when initialised' do
    it 'has an id' do
      loan = create_loan
      expect(loan.id).to eq(5)
    end

    it 'knows how much was borrowed' do
      loan = create_loan
      expect(loan.amount_borrowed).to eq(1000)
    end

    it 'has an interest rate' do
      loan = create_loan
      expect(loan.rate).to eq(2)
    end

    it 'calculates the amount outstanding' do
      loan = create_loan
      rate = loan.rate
      amount = loan.amount_borrowed
      expect(loan.outstanding).to eq(amount + (amount * rate))
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

    it 'has an empty transactions array' do
      loan = create_loan
      expect(loan.transactions).to eq([])
    end
  end

  context 'making payments' do
    it 'can make a payment' do
      loan = create_loan
      expect { loan.make_payment(100) }
        .to change { loan.outstanding }.by(-100)
    end

    it 'adds a transaction to the array' do
      loan = create_loan
      Timecop.freeze
      loan.make_payment(100)
      expect(loan.transactions.last.type).to eq(:loan_payment)
      expect(loan.transactions.last.amount).to eq(100)
      expect(loan.transactions.last.date).to eq(Time.now)
      Timecop.return
    end
  end
end
