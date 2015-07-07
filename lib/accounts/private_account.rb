# Definition of Private Account Class
class PrivateAccount < BaseAccount
  def initialize(holder, id)
    super
    @type = :Private
  end
end
