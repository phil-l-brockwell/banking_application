# Definition of Controller Class
class Controller
  def initialize
    @main_items = ['Create Current Account',
                   'Deposit',
                   'Display Balance',
                   'Withdraw',
                   'Transfer Money',
                   'Pay Interest',
                   'Add Account Holder',
                   'Show all accounts held by a customer',
                   'View Transactions']
    @accounts =   ['Current',
                   'Savings',
                   'Student',
                   'Business',
                   'SMB',
                   'IR']
  end

  def enter
    input = nil
    until input == ''
      puts "Press 'ENTER' to begin"
      input = gets.chomp
    end
  end

  def main_menu
    @main_items.each_with_index { |item, index| puts "#{index + 1}. #{item}" }
    puts "What would you like to do?\nEnter a number and hit 'ENTER'"
    gets.chomp
  end

  def selector(input)
    if input == 
      
    end
  end

  def start
    enter
    input = main_menu.to_i
    selector(input)
  end
end
