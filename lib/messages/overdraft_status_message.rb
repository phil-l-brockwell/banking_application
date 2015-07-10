class OverDraftStatusMessage < SuccessMessage

  attr_reader :account_id, :overdraft, :overdraft_on

  def initialize(account)
    @account_id = account.id
    @overdraft = account.overdraft
    @overdraft_on = account.overdraft_on
    @main = build_main
  end

  def build_main
    return ["Account ID: #{@account_id} has an active overdraft of £#{@overdraft}"] if @overdraft_on
    ["Account ID: #{@account_id} has no active overdraft"]
  end
end
