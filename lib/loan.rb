require 'date'

class Loan

  attr_accessor :amount_borrowed, :holder, :rate,
                :term, :repayment_date, :payments

  def initialize(options={})
    @amount_borrowed = options[:borrowed]
    @holder = options[:holder]
    @term = options[:term]
    @rate = options[:rate]
    @repayment_date = DateTime.now >> (12 * @term)
    @payments = []
  end
end
