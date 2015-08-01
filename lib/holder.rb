# Definition of Holder Class
# this class will be used to store details of a holder
class Holder
  attr_reader :name, :id
  # defines readable attributes, equivalent of a getter method in java or other languages
  # holder.name will return the holders name

  # initialize takes a name and id as an arg
  def initialize(name, id)
    @name = normalise(name)
    # sets name attributes by normalising the name arg
    @id = id
    # sets id
  end

  # private area
  private

  # method to normalise a name string
  def normalise(name)
    # .split converts the string to an array, each word is a value
    # .map loops over each value of the array and returns a modified version of the array
    # .capitalize makes the first letter a capital
    # .gsub removes any special chars or blank spaces
    # .join(' ') puts the string back together with a space between each letter
    name.split.map { |word| word.capitalize.gsub(/[^0-9A-Za-z]/, '') }.join(' ')
  end
end
