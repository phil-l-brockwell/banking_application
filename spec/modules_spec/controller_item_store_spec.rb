require 'exceptions/item_exist'
require 'modules/controller_item_store'
# Holder class to include ControllerItemStore and run tests on
class ControllerStoreHolder; include ControllerItemStore; end

describe 'ControllerItemStore' do
  let(:item)       { double :item, id: 0       }
  let(:item_store) { ControllerStoreHolder.new }

  context 'when initialised' do
    it 'has an empty hash of items' do
      expect(item_store.store).to eq({})
    end

    it 'has an id' do
      expect(item_store.id).to eq(1)
    end
  end

  context 'when adding items' do
    it 'adds the item' do
      expect(item_store.store.length).to eq(0)
      item_store.add(item)
      expect(item_store.store.length).to eq(1)
    end
  end

  context 'when finding an item' do
    it 'can locate the item with its id' do
      item_store.add(item)
      expect(item_store.store[0]).to eq(item)
    end

    it 'knows it has an item' do
      item_store.add(item)
      expect(item_store.find(0)).to eq(item)
    end

    it 'raises an error if an item does not exist' do
      expect { item_store.find(69) }
        .to raise_error(ItemExist)
    end
  end
end
