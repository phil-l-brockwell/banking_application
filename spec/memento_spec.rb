require 'memento'

describe 'Memento' do
  context 'when initialised' do
    let(:memento) { Memento.new(100.00, 57) }

    it 'has a balance' do
      expect(memento.balance).to eq(100.00)
    end

    it 'has an account id' do
      expect(memento.account_id).to eq(57)
    end
  end
end
