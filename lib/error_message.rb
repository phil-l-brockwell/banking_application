class ErrorMessage < BaseMessage

  def initialize(text, options = {})
    super
    @outcome = :error
  end
end
