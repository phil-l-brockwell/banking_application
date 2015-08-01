# Definition of AddHolderSuccessMessage
# returned when a new holder is added to an account
class AddHolderSuccessMessage < Message
  def initialize(holder, account)
    super
    @main = ["Holder ID: #{holder.id} added to Account ID: #{account.id}"]
  end
end
