# Definition of Holder Class
class Holder
  attr_reader :name, :id

  def initialize(name, id)
    @name = normalise(name)
    @id = id
  end

  def normalise(string)
    string.split.map { |word| word.capitalize.gsub(/[^0-9A-Za-z]/, '') }.join(' ')
  end
end
