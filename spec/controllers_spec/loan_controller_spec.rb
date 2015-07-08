require 'controllers/loan_controller'

describe 'LoanController' do
  let(:test_controller) { LoanController.new }

  context 'when initialised' do
    it 'has a hash of loans' do
      expect(test_controller.loans).to eq({})
    end

    it 'has a loan id' do
      expect(test_controller.id).to eq(1)
    end
  end
end
