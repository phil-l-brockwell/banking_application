# Defintion of Account Success Message Class
class AccountSuccessMessage < SuccessMessage
  attr_reader :new_account_id

  def initialize(new_account)
    super
    @new_account_id = new_account.id
    @main = ["New Account created. ID number is: #{@new_account_id}"]
  end
end
