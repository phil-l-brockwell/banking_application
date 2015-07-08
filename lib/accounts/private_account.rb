# Definition of Private Account Class
class PrivateAccount < CustomerAccount
  def initialize(holder, id)
    super
    @type = :Private
  end
end
