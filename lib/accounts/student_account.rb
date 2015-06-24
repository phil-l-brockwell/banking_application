# Definition of Student Account Class
class StudentAccount < BaseAccount
  def initialize(holder, account_number)
    super
    @type = :student
  end
end
