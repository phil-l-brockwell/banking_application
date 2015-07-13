require 'messages/show_loan'

describe 'ShowLoanMessage' do
  context 'when initialised' do
    let(:holder) { double :holder, name: 'Robert Pulson' }
    let(:transaction) { double :transaction, amount: 10, date: '1/2/3' }
    let(:loan) { double :loan, holder: holder, transactions: [transaction], repayment_date: '1/1/1', outstanding: 100_00 }
    let(:test_message) { ShowLoanMessage.new(loan) }

    it 'knows the outstanding amount' do
      expect(test_message.outstanding).to eq(100_00)
    end

    it 'knows the holders name' do
      expect(test_message.holder_name).to eq('Robert Pulson')
    end

    it 'knows the repayment_date' do
      expect(test_message.repayment_date).to eq('1/1/1')
    end

    it 'has the transactions array' do
      expect(test_message.transactions).to eq([transaction])
    end

    it 'has the correct main text' do
      expect(test_message.main).to eq(['Holder Name: Robert Pulson',
                                       'Final Repayment Date: 1/1/1',
                                       'Outstanding Amount: £10000',
                                       'Transactions:',
                                       '1. Date: 1/2/3, Amount: £10'])
    end
  end
end
