require 'messages/overdraft_status'

describe 'OverdraftStatusMessage' do
  context 'when initialised' do
    let(:account) { double :account, id: 1, output_overdraft: '£100.00', overdraft_on: true }
    let(:test_message) { OverdraftStatusMessage.new(account) }

    it 'knows the account id' do
      expect(test_message.account_id).to eq(1)
    end

    it 'knows if the overdraft is on' do
      expect(test_message.overdraft_on).to eq(true)
    end

    it 'knows the overdraft amount' do
      expect(test_message.overdraft).to eq('£100.00')
    end

    it 'has the correct main text' do
      expect(test_message.main)
        .to eq(['Account ID: 1 has an overdraft of £100.00'])
    end
  end

  context 'when initialised with a deactivated overdraft account' do
    let(:account) { double :account, id: 1, output_overdraft: 0, overdraft_on: false }
    let(:test_message) { OverdraftStatusMessage.new(account) }

    it 'has the correct main text' do
      expect(test_message.main).to eq(['Account ID: 1 has no overdraft'])
    end
  end
end
