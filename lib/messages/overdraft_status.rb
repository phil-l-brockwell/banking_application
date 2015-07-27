# Definition of Overdraft Status Message Class
class OverdraftStatusMessage < Message

  def initialize(account)
    super
    @main = build_main(account)
  end

  def build_main(account)
    return ["Account ID: #{account.id} has no overdraft"] unless account.overdraft_on
    ["Account ID: #{account.id} has an overdraft of #{account.output_overdraft}"]
  end
end
