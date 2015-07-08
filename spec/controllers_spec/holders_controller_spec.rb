require 'controllers/holders_controller'

describe 'HoldersController' do
  let(:holders_ctrl) { HoldersController.new }

  def create_holder_and_return_id
    message = holders_ctrl.create_holder('Robert Pulson')
    message.new_holder_id
  end

  context 'when initialised' do

    it 'has a hash of holders' do
      expect(holders_ctrl).to respond_to(:store)
    end

    it 'has a current holder id' do
      expect(holders_ctrl.id).to eq(1)
    end
  end

  context 'when creating a holder' do
    it 'increments the holder number' do
      expect { create_holder_and_return_id }
        .to change { holders_ctrl.id }.by(1)
    end

    it 'returns a message with the new holders id' do
      id = holders_ctrl.id
      new_holder_id = create_holder_and_return_id
      expect(new_holder_id).to eq(id)
    end

    it 'gives the new holder the correct holder id' do
      id = create_holder_and_return_id
      expect(holders_ctrl.store[id].id).to eq(id)
    end

    it 'adds the new holder to the holders hash' do
      id = create_holder_and_return_id
      expect(holders_ctrl.store[id].name).to eq('Robert Pulson')
    end
  end
end
