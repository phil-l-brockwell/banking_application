# Definition of Boundary Class
class Boundary
  def show_menu
    MENU_ITEMS.each { |key, value| puts_with_sleep "#{key}. #{value}" }
    puts_with_sleep 'Make a selection and Press Enter'
  end

  def start
    show_menu
    until MENU_ITEMS.has_key? gets.chomp
      puts_with_sleep 'Unrecognised option, try again...'
      show_menu
    end
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

  private

  def puts_with_sleep(string)
    puts string
    sleep(0.5)
  end
end

test = Boundary.new
test.start
