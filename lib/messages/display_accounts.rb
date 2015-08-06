# Definition of DisplayAccountsMessage Class
# returned when display accounts method is completed
class DisplayAccountsMessage < Message
  attr_reader :accounts

  def initialize(accounts)
    super
    @accounts = accounts
    # saves accounts passed to class variable
    @main = build_main
  end

  # defines output method
  def output
    @main.unshift(@header)
  end

  private

  # method used to build the main message body
  def build_main
    # map returns a modified version of the existing array
    # setting each account as a, then performing the code for each account
    @accounts.map do |a|
      "ID: #{a.id}, Balance: #{a.output_balance}, Type: #{a.type}"
    end
  end
end
