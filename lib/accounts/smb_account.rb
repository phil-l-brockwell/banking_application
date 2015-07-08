# Definition of SMB Account Class
class SMBAccount < CustomerAccount
  def initialize(holder, account_number)
    super
    @type = :SMB
  end
end
