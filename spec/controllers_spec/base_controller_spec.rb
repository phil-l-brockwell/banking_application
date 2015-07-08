require 'controllers/base_controller'

describe 'BaseController' do
  let(:base_ctrl) { BaseController.new }

  context 'when initialised' do
    it 'has a hash of items' do
      expect(base_ctrl.store).to eq({})
    end

    it 'has an id' do
      expect(base_ctrl.id).to eq(1)
    end
  end
end
