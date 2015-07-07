class LCRAccount < BaseAccount

  def initialize(holder, id)
    super
    @type = :LCR
    @overdraft = false
  end
end
