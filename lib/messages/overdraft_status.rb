# Definition of Overdraft Status Message Class
class OverdraftStatusMessage < Message
  attr_reader :account_id, :overdraft, :overdraft_on

  def initialize(account)
    super
    @account_id = account.id
    @overdraft = account.output_overdraft
    @overdraft_on = account.overdraft_on
    @main = build_main
  end

  def build_main
    return ["Account ID: #{@account_id} has no overdraft"] unless @overdraft_on
    ["Account ID: #{@account_id} has an overdraft of #{@overdraft}"]
  end
end
