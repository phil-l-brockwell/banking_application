# Definition of LCR Account Class
class LCRAccount < CustomerAccount
  def initialize(holder, id)
    super
    @type = :LCR
    @overdraft = false
  end

  def overdraft
    fail OverdraftDenied    
  end

  def overdraft_on
    fail OverdraftDenied
  end
end
