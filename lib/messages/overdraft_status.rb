# Definition of Overdraft Status Message Class
# returned when an overdraft is switched on, off or status checked
class OverdraftStatusMessage < Message

  def initialize(account)
    super
    @main = build_main(account)
  end

  private

  # method to build main body text
  def build_main(account)
    # conditional return allows the message to morph if the overdraft is on or off
    return ["Account ID: #{account.id} has no overdraft"] unless account.overdraft_on
    ["Account ID: #{account.id} has an overdraft of #{account.output_overdraft}"]
  end
end
