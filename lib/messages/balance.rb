# Defintion of Balance Message Class
# returned when a balance is requested
class BalanceMessage < Message
  def initialize(account)
    super
    @main = ["Balance of Account ID: #{account.id} is #{account.output_balance}"]
  end
end
