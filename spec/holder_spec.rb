require 'holder'

describe 'Holder' do
  let(:test_holder) { Holder.new('Robert Pulson', 0) }

  it 'has a first name' do
    expect(test_holder).to respond_to(:name)
  end

  it 'is initialised with a name' do
    expect(test_holder.name).to eq('Robert Pulson')
  end
end
