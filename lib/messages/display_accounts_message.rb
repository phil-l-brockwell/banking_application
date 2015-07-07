class DisplayAccountsMessage < SuccessMessage

  attr_reader :accounts

  def initialize(accounts)
    super
    @accounts = accounts
    @main = build_main
  end

  def build_main
    @accounts.map do |account|
      "ID: #{account.id}, Balance: £#{account.balance}, Type: #{account.type}"
    end
  end
end
