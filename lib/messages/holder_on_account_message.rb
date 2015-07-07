class HolderOnAccountMessage < ErrorMessage

  attr_reader :account_id, :holder_id

  def initialize(holder, account)
    super
    @account_id = account.id
    @holder_id = holder.id
    @main = ["Holder ID: #{@holder_id} already exists on Account ID: #{@account_id}"]
  end
end
