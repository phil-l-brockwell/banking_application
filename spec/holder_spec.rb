require 'holder'

describe 'Holder' do
  let(:test_holder) { Holder.new('Robert Pulson') }

  it 'has a first name' do
    expect(test_holder).to respond_to(:name)
  end

  it 'is initialised with a name' do
    expect(test_holder.name).to eq('Robert Pulson')
  end

  it 'can add a unique id' do
    test_holder.add_id(0)
    expect(test_holder.id).to eq(0)
  end
end
