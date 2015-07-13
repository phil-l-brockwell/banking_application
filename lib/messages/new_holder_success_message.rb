# Definition of Holder Success Message
class NewHolderSuccessMessage < SuccessMessage
  attr_reader :new_holder_id, :new_holder_name

  def initialize(new_holder)
    super
    @new_holder_name = new_holder.name
    @new_holder_id = new_holder.id
    @main = ["New Holder: #{new_holder_name}, created. ID is: #{new_holder_id}"]
  end
end
