require 'controllers/holders_controller'

describe 'HoldersController' do
  let(:holders_ctrl) { HoldersController.instance }

  context 'when creating a holder' do
    it 'increments the holder number' do
      expect { holders_ctrl.create('Robert Pulson') }
        .to change { holders_ctrl.id }.by(1)
    end

    it 'adds the new holder to the holders hash' do
      id = holders_ctrl.id
      holders_ctrl.create('Robert Pulson')
      holder = holders_ctrl.find(id)
      expect(holder.name).to eq('Robert Pulson')
      expect(holder.id).to eq(id)
    end
  end
end
