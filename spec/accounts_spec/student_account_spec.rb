require 'accounts/student_account'

describe 'StudentAccount' do
  context 'when initialised' do
    let(:test_holder)  { double :test_holder                }
    let(:test_account) { StudentAccount.new(test_holder, 1) }

    it 'has the correct type' do
      expect(test_account.type).to be(:Student)
    end
  end
end
