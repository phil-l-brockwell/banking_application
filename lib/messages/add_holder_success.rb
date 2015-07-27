# Definition of AddHolderSuccessMessage
class AddHolderSuccessMessage < Message
  def initialize(holder, account)
    super
    @main = ["Holder ID: #{holder.id} added to Account ID: #{account.id}"]
  end
end
