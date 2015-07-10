require 'messages/overdraft_status_message'

describe 'OverdraftStatusMessage' do
  context 'when initialised' do
    let(:account) { double :account, id: 1, overdraft: 100, overdraft_on: true }
    let(:test_message) { OverdraftStatusMessage.new(account) }
    
    it 'knows the account id' do
      expect(test_message.account_id).to eq(1)
    end

    it 'knows if the overdraft is on' do
      expect(test_message.overdraft_on).to eq(true)
    end

    it 'knows the overdraft amount' do
      expect(test_message.overdraft).to eq(100)
    end

    it 'has the correct main text' do
      expect(test_message.main).to eq(['Account ID: 1 has an active overdraft of £100'])
    end
  end

  context 'when initialised with a deactivated overdraft account' do
    let(:account) { double :account, id: 1, overdraft: 0, overdraft_on: false }
    let(:test_message) { OverdraftStatusMessage.new(account) }

    it 'has the correct main text' do
      expect(test_message.main).to eq(['Account ID: 1 has no active overdraft'])
    end
  end
end
