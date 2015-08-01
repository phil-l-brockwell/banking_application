# Definition of Student Account Class
class StudentAccount < CustomerAccount
  # inherits from customer account
  def initialize(holder, account_number)
    # initialize method, called when .new is called on the class
    super
    # calls super classes initialize method
    @type = :Student
    # sets type
  end
end
