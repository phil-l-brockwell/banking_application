require 'messages/error_message'
require 'messages/holder_on_account_message'

describe 'HolderOnAccountMessage' do
  context 'when initialised' do
    let(:test_holder)  { double :holder, id: 9                              }
    let(:test_account) { double :account, id: 2                             }
    let(:test_message) { HolderOnAccountMessage.new(test_holder, test_account) }

    it 'knows the account id' do
      expect(test_message.account_id).to eq(2)
    end

    it 'knows the holder id' do
      expect(test_message.holder_id).to eq(9)
    end

    it 'has the correct main text' do
      expect(test_message.main).to eq(['Holder ID: 9 already exists on Account ID: 2'])
    end
  end
end