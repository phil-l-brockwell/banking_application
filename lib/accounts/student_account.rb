# Definition of Student Account Class
class StudentAccount < CustomerAccount
  def initialize(holder, account_number)
    super
    @type = :Student
  end
end
