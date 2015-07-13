# Definition of AddHolderSuccessMessage
class AddHolderSuccessMessage < Message
  attr_reader :account_id, :holder_id

  def initialize(holder, account)
    super
    @holder_id = holder.id
    @account_id = account.id
    @main = ["Holder ID: #{@holder_id} added to Account ID: #{@account_id}"]
  end
end
