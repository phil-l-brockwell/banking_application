require './lib/controller'
# Definition of Boundary Class
class Boundary
  def initialize
    @controller = Controller.new
  end

  def show_menu
    MENU_ITEMS.each { |key, value| puts_with_sleep "#{key}. #{value}" }
    puts_with_sleep 'Make a selection and Press Enter'
  end

  def start
    show_menu
    input = gets.chomp
    until MENU_ITEMS.key? input
      puts_with_sleep 'Unrecognised option, try again...'
      show_menu
      input = gets.chomp
    end
    select_option(input)
  end

  def select_option(input)
    create_holder if input.to_i == 0
    create_account if input.to_i == 1
    start
  end

  def create_holder
    puts 'Enter Name and Press Enter'
    name = gets.chomp
    response = @controller.create_holder name
    puts response
  end

  def create_account
    ACCOUNT_TYPES.each { |key, value| puts_with_sleep "#{key}. #{value} Account" }
    puts_with_sleep 'Make a selection and Press Enter'
    input = gets.chomp
    until MENU_ITEMS.key? input
      puts_with_sleep 'Unrecognised option, try again...'
      ACCOUNT_TYPES.each { |key, value| puts_with_sleep "#{key}. #{value} Account" }
      input = gets.chomp
    end
    type = ACCOUNT_TYPES[input]
    puts_with_sleep 'Enter Holder ID'
    holder_id = gets.chomp.to_i
    response = @controller.open_account(type, with: holder_id)
    puts response
  end

  MENU_ITEMS = { '0' => 'Create New Holder',
                 '1' => 'Create an Account',
                 '2' => 'Make a Deposit',
                 '3' => 'Display Account Balance',
                 '4' => 'Make a Withdrawal',
                 '5' => 'Make a Transfer',
                 '6' => 'Pay Interest',
                 '7' => 'Add Account ',
                 '8' => 'Show Customers Accounts',
                 '9' => 'View Account Transactions' }

  ACCOUNT_TYPES = { '0' => :Current,
                    '1' => :Savings,
                    '2' => :Business,
                    '3' => :IR,
                    '4' => :SMB,
                    '5' => :Student }

  private

  def puts_with_sleep(string)
    puts string
    sleep(0.5)
  end
end

test = Boundary.new
test.start
