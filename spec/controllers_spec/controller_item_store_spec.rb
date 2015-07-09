require 'controllers/controller_item_store'

# Holder class to include ControllerItemStore and run tests on
class ControllerStoreHolder; include ControllerItemStore; end

describe 'ControllerItemStore' do
  let(:item_store) { ControllerStoreHolder.new }

  context 'when initialised' do
    it 'has a hash of items' do
      expect(item_store.store).to eq({})
    end

    it 'has an id' do
      expect(item_store.id).to eq(1)
    end
  end
end
