# Definition of Master Account Class
# the master account will be used to pay and receive the banks interest payments
# although core functionality will be the same as customer accounts, the account will not raise exceptions and has no limits
class MasterAccount < BaseAccount
  # inherits from base account
  def initialize
    # defines initialize method
    super
    # calls super initialize method
    @balance = 100_000_0.00
    # sets balance to one million
    @type = :Master
    # sets type
  end
end
