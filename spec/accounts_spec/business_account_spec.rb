require 'accounts/business_account'

describe 'BusinessAccount' do
  context 'when initialised' do
    let(:test_holder)  { double :test_holder                 }
    let(:test_account) { BusinessAccount.new(test_holder, 1) }

    it 'has the correct type' do
      expect(test_account.type).to be(:Business)
    end

    it 'has the correct limit' do
      expect(test_account.limit).to eq(500)
    end
  end
end
