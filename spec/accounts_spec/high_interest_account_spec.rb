require 'accounts/high_interest_account'

describe 'HighInterestAccount' do
  context 'when initialised' do
    let(:holder)       { double :holder                     }
    let(:test_account) { HighInterestAccount.new(holder, 1) }

    it 'has the correct type' do
      expect(test_account.type).to eq(:HighInterest)
    end

    it 'has a higher interest rate than a current account' do
      current_account = CurrentAccount.new(holder, 1)
      expect(test_account.interest_rate)
        .to be > (current_account.interest_rate)
    end
  end
end
