require 'messages/display_accounts'

describe 'DisplayAccountsMessage' do
  context 'when initialised' do
    let(:a1) { double :account, id: 1,  output_balance: '£10', type: :current  }
    let(:a2) { double :account, id: 15, output_balance: '£1',  type: :savings  }
    let(:a3) { double :account, id: 27, output_balance: '£56', type: :business }
    let(:accounts)     { [a1, a2, a3] }
    let(:test_message) { DisplayAccountsMessage.new(accounts) }

    it 'has the array of accounts' do
      expect(test_message.accounts).to eq(accounts)
    end

    it 'has the correct main text' do
      expect(test_message.main)
        .to eq(['ID: 1, Balance: £10, Type: current',
                'ID: 15, Balance: £1, Type: savings',
                'ID: 27, Balance: £56, Type: business'])
    end
  end
end
