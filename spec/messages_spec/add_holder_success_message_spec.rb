require 'messages/add_holder_success_message'

describe 'AddHolderSuccessMessage' do
  context 'when initialised' do
    let(:test_account) { double :account, id: 1                                 }
    let(:test_holder)  { double :holder, id: 7                                  }
    let(:test_message) { AddHolderSuccessMessage.new(test_holder, test_account) }

    it 'knows the account id' do
      expect(test_message.account_id).to eq(1)
    end

    it 'knows the holder id' do
      expect(test_message.holder_id).to eq(7)
    end

    it 'has the correct main text' do
      expect(test_message.main[0]).to eq('Holder ID: 7 added to Account ID: 1')
    end
  end
end
