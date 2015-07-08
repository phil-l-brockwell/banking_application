require 'controllers/interest_controller'

describe 'InterestController' do
  let(:test_account)    { double :account, balance: 2500.00, interest_rate: 0.1 }
  let(:test_controller) { InterestController.new }

  context 'when initialised' do
    it 'has a master account' do
      expect(test_controller.account.type).to eq(:Master)
    end
  end

  context 'when calculating interest' do
    it 'returns the interest due on an account' do
      expect(test_controller.calculate_interest_on(test_account))
        .to eq(250)
    end

    it 'can deduct the interest from the master account' do
      expect { test_controller.deduct_interest(500) }
        .to change { test_controller.account.balance }.by(-500)
    end
  end
end
