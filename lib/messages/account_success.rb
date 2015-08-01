# Defintion of Account Success Message Class
# returned when new account is created
class AccountSuccessMessage < Message
  def initialize(new_account)
    super
    @main = ["New Account created. ID number is: #{new_account.id}"]
  end
end
