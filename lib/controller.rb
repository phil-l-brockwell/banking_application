class Controller

  def initialize
    @main_menu_items = ['Create Current Account',
                        'Deposit',
                        'Display Balance',
                        'Withdraw',
                        'Transfer Money',
                        'Pay Interest',
                        'Add Account Holder',
                        'Show all accounts held by a customer',
                        'View Transactions']
  end

  def enter
    input = nil
    until input == ''
      puts "Press 'ENTER' to begin"
      input = gets.chomp
    end
    main_menu
  end

  def main_menu
    @main_menu_items.each_with_index { |item, index| puts "#{index + 1}. #{item}" }
    puts 'What would you like to do?'
    puts "Enter a number and hit 'ENTER'"
    gets.chomp
  end
end
