require 'messages/display_accounts_message'

describe 'DisplayAccountsMessage' do
  context 'when initialised' do
    let(:account_1)    { double :account, id: 1, balance: 1000, type: :current }
    let(:account_2)    { double :account, id: 15, balance: 1, type: :savings   }
    let(:account_3)    { double :account, id: 27, balance: 56, type: :business }
    let(:accounts)     { [account_1, account_2, account_3]                     }
    let(:test_message) { DisplayAccountsMessage.new(accounts)                  }

    it 'has the array of accounts' do
      expect(test_message.accounts).to eq(accounts)
    end

    it 'has the correct main text' do
      expect(test_message.main).to eq(['ID: 1, Balance: £1000, Type: current',
                                           'ID: 15, Balance: £1, Type: savings',
                                           'ID: 27, Balance: £56, Type: business'])
    end
  end
end
