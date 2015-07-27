# Defintion of Balance Message Class
class BalanceMessage < Message
  def initialize(account)
    super
    @main = ["Balance of Account ID: #{account.id} is #{account.output_balance}"]
  end
end
