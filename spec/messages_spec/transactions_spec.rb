require 'messages/transactions'

describe 'TransactionsMessage' do
  context 'when initialised' do
    let(:t_1) { double :tran, type: :Deposit,    date: '1/1/01', output_amount: '£34.89' }
    let(:t_2) { double :tran, type: :Withdrawal, date: '2/2/02', output_amount: '£12.89' }
    let(:t_3) { double :tran, type: :Deposit,    date: '3/3/03', output_amount: '£89.89' }
    let(:transactions)  { [t_1, t_2, t_3]                                      }
    let(:test_message)  { TransactionsMessage.new(transactions)                }

    it 'has the transactions array' do
      expect(test_message.transactions).to eq(transactions)
    end

    it 'has the correct main text' do
      expect(test_message.main)
        .to eq(['1. Type: Deposit, Date: 1/1/01, Amount: £34.89',
                '2. Type: Withdrawal, Date: 2/2/02, Amount: £12.89',
                '3. Type: Deposit, Date: 3/3/03, Amount: £89.89'])
    end

    it 'has the correct output' do
      expect(test_message.output)
        .to eq(['Transaction Successful.',
                '1. Type: Deposit, Date: 1/1/01, Amount: £34.89',
                '2. Type: Withdrawal, Date: 2/2/02, Amount: £12.89',
                '3. Type: Deposit, Date: 3/3/03, Amount: £89.89'])
    end
  end
end
