require 'timecop'
# requires timecop for testing timed events
require 'loan'
# requires test subject
require 'exceptions/over_payment'
# requires exception for testing exceptions

describe 'Loan' do
  # sets up the test subject

  let(:test_holder) { double :holder }
  # creates a double holder that will be used to initialise loans

  def create_loan
    # helper method to create a loan and return that loan
    options = { holder: test_holder, borrowed: 1000, term: 2, rate: 2 }
    # hash of key value pairs to initialise loan
    Loan.new(options, 5)
    # creates loan and returns it
  end

  context 'when initialised' do
    # tests inside this block will test events after exclusively after initialisation
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
      # tests that the loan is calculating the correct outstanding amount
    end

    it 'has a holder' do
      loan = create_loan
      expect(loan.holder).to eq(test_holder)
    end

    it 'has a term' do
      loan = create_loan
      expect(loan.term).to eq(2)
    end

    it 'has an empty transactions array' do
      loan = create_loan
      expect(loan.transactions).to eq([])
    end
  end

  context 'making payments' do
    # tests inside this block will test for payment related events

    it 'can make a payment' do
      loan = create_loan
      expect { loan.make_payment(100) }
        .to change { loan.outstanding }.by(-100)
    end

    it 'raises an error if the payment is greater than the outstanding amount' do
      loan = create_loan
      overpayment = loan.outstanding + 1
      expect { loan.make_payment(overpayment) }.to raise_error(OverPayment)
    end

    it 'adds a transaction to the array' do
      loan = create_loan
      Timecop.freeze
      # freezes time so that the transaction time can be tested
      loan.make_payment(100)
      expect(loan.transactions.last.type).to eq(:loan_payment)
      expect(loan.transactions.last.amount).to eq(100)
      expect(loan.transactions.last.date)
        .to eq(Time.now.strftime('%a %d %b %Y'))
      Timecop.return
    end
  end
end
