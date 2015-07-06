require 'base_message'
require 'account_error_message'

describe 'AccountErrorMessage' do
  context 'when initialised' do

    let(:test_message) { AccountErrorMessage.new(69) } 

    it 'knows the incorrect holder ID' do
      expect(test_message.incorrect_holder_id).to eq(69)
    end

    it 'has the correct output' do
      expect(test_message.output)
        .to eq('Transaction Error. Holder ID: 69 does not exist.')
    end
  end
end
