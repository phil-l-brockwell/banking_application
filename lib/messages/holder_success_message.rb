# Definition of Holder Success Message
class HolderSuccessMessage < BaseMessage
  attr_accessor :new_holder_id, :new_holder_name

  def initialize(new_holder)
    super
    @new_holder_name = new_holder.name
    @new_holder_id = new_holder.id
    @output = "Transaction Successful. New Holder: #{new_holder_name}, created. ID number is: #{new_holder_id}"
  end
end
