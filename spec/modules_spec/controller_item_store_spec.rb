require 'exceptions/item_exist'
# requires exception to test exceptions
require 'modules/controller_item_store'
# requires test subject
class ControllerStoreHolder; include ControllerItemStore; end
# Holder class to include ControllerItemStore and run tests on

describe 'ControllerItemStore' do
  # sets up a test subject
  let(:item)       { double :item, id: 0       }
  # creates a item double to simulate behaviour for our tests, with an id of 0
  let(:item_store) { ControllerStoreHolder.new }
  # creates an instance of a controller item store to test

  context 'when initialised' do
    # these tests will test behaviour that occurs after initialisation

    it 'has an empty hash of items' do
      expect(item_store.store).to eq({})
    end

    it 'has an id' do
      expect(item_store.id).to eq(1)
    end
  end

  context 'when adding items' do
    # these tests will test behaviour related to adding items
    it 'adds the item' do
      expect(item_store.store.length).to eq(0)
      item_store.add(item)
      expect(item_store.store.length).to eq(1)
    end
  end

  context 'when finding an item' do
    # these tests will test behaviour related to finding items
    it 'can locate the item with its id' do
      item_store.add(item)
      expect(item_store.store[0]).to eq(item)
    end

    it 'knows it has an item' do
      item_store.add(item)
      expect(item_store.find(0)).to eq(item)
    end

    it 'raises an error if an item does not exist' do
      expect { item_store.find(69) }.to raise_error(ItemExist)
    end
  end
end
