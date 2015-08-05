require 'controllers/holders_controller'
# require test subject

describe 'HoldersController' do
  # set up test subject

  let(:holders_ctrl) { HoldersController.instance }
  # create instance of the controller

  context 'when creating a holder' do
    # test inside this block will test behaviour that occurs when creating a holder
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
