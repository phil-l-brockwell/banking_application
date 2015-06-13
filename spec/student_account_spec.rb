require 'student_account'

describe 'StudentAccount' do
  it 'can initialise with the correct type' do
    test_holder = double :test_holder
    test_student_account = StudentAccount.new(test_holder, 1)
    expect(test_student_account.type).to be(:student)
  end
end
