# Definition of Holder Class
class Holder
  attr_reader :name, :id

  def initialize(name)
    @name = name
  end

  def add_id(id)
    @id = id
  end
end
