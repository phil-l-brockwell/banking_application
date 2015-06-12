class Holder

  attr_reader :name, :accounts

  def initialize(name)
    @name = name
    @accounts = []
  end

  def add_account(account)
    @accounts << account
  end
end
