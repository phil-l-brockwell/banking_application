# Definition of SMB Account Class
class SMBAccount < BaseAccount
  def initialize(holder, account_number)
    super
    @type = :SMB
  end
end