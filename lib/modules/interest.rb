# Definition of Interest Module
# this module will be responsible for calculating and making interest payments on accounts
# it will be included by the accounts controller
module Interest

  attr_reader :master

  def initialize
    @master = MasterAccount.new
    # creates an instance of a master account
    # used to pay and receive interest
  end
  # method pays interest on a given account
  def pay_interest_on(account)
    # first interest is calculated and stored to local variable
    interest = calculate_interest(account)
    # if statement used to check if account is overdrawn
    if account.overdrawn?
      # if it is the interest is subtracted
      account.withdraw interest
      @master.deposit interest
    else
      # else the interest is added
      @master.withdraw interest
      account.deposit interest
    end
  end

  # private area
  private

  # calculates interest due, abs gives absolute value
  def calculate_interest(account)
    (account.balance * account.interest_rate).abs
  end
end
