require 'holder_success_message'

describe 'HolderSuccessMessage' do

  context 'when initialised' do
    
    let(:test_holder)  { double :test_holder, name: 'Phil', id: 0 }
    let(:test_message) { HolderSuccessMessage.new(test_holder)    }

    it 'knows the new holders name' do
      expect(test_message.new_holder_name).to eq('Phil')
    end

    it 'knows the new holders id' do
      expect(test_message.new_holder_id).to eq(0)
    end

    it 'has an output' do
      expect(test_message.output)
        .to eq("Transaction Successful. New Holder: Phil, created. ID number is: 0")
    end
  end
end
