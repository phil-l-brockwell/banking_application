require 'messages/add_holder_success'

describe 'AddHolderSuccessMessage' do
  context 'when initialised' do
    let(:account)      { double :account, id: 1                       }
    let(:holder)       { double :holder,  id: 7                       }
    let(:test_message) { AddHolderSuccessMessage.new(holder, account) }

    it 'has the correct main text' do
      expect(test_message.main[0]).to eq('Holder ID: 7 added to Account ID: 1')
    end
  end
end
