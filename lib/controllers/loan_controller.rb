class LoanController

  attr_reader :loans, :id

  def initialize
    @loans = {}
    @id = 1
  end

end
