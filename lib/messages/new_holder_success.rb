# Definition of Holder Success Message
# returned when a new holder is created
class NewHolderSuccessMessage < Message
  def initialize(new_holder)
    super
    @main = ["New Holder: #{new_holder.name}, created. ID is: #{new_holder.id}"]
  end
end
