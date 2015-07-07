class PrivateAccount < BaseAccount

  def initialize(holder, id)
    super
    @type = :Private
  end
end
