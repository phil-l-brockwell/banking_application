# Definition of Private Account Class
class PrivateAccount < CustomerAccount
  # inherits from customer account
  def initialize(holder, id)
    # initialize method is called when .new is called on the class
    super
    # calls super classes initialize method first
    @type = :Private
    # sets type
  end
end
