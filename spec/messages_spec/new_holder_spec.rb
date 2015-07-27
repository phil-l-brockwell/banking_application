require 'messages/new_holder_success'

describe 'NewHolderSuccessMessage' do
  context 'when initialised' do
    let(:test_holder)  { double :test_holder, name: 'Phil', id: 0 }
    let(:test_message) { NewHolderSuccessMessage.new(test_holder)    }

    it 'has the correct main text' do
      expect(test_message.main[0])
        .to eq('New Holder: Phil, created. ID is: 0')
    end
  end
end
