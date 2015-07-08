# Definition of LCR Account Class
class LCRAccount < CustomerAccount
  def initialize(holder, id)
    super
    @type = :LCR
    @overdraft = false
  end
end
