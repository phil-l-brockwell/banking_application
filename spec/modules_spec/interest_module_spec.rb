require 'modules/interest'
# requires test subject
class InterestHolder; include Interest; end
# Holder class to include Interest and run tests on

describe 'InterestHolder' do
  # sets up a test subject
  let(:interest_holder) { InterestHolder.new }
  # creates an instance of a controller item store to test
  let(:test_account) { double :account, balance: 100, interest_rate: 0.1, overdrawn?: false }

  context 'when initialised' do
    # these tests will test behaviour that occurs after initialisation
    it 'has a master account' do
      expect(interest_holder.master.type).to eq(:Master)
    end
  end

  context 'when paying interest' do
    it 'pays the interest' do
      expect(test_account).to receive(:deposit).with(10)
      interest_holder.pay_interest_on(test_account)
    end
  end
end
