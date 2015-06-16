# Definition of Holder Class
class Holder
  attr_reader :name, :accounts, :id

  def initialize(name)
    @name = name
    @accounts = []
  end

  def add_id(id)
    @id = id
  end

  def add_account(account)
    @accounts << account
  end
end
