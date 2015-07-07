require 'accounts/high_interest_account'

describe 'HighInterestAccount' do
  context 'when initialised' do
    let(:holder)       { double :holder                     }
    let(:test_account) { HighInterestAccount.new(holder, 1) }

    it 'has the correct type' do
      expect(test_account.type).to eq(:HighInterest)
    end

    it 'has a higher interest rate' do
      expect(test_account.interest_rate).to eq(0.2)
    end
  end
end
