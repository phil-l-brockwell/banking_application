require './lib/controller'
# Definition of Boundary Class
class Boundary
  MENU_ITEMS = {  1  => { output: 'Create New Holder'         },
                  2  => { output: 'Create an Account'         },
                  3  => { output: 'Make a Deposit'            },
                  4  => { output: 'Display Account Balance'   },
                  5  => { output: 'Make a Withdrawal'         },
                  6  => { output: 'Make a Transfer'           },
                  7  => { output: 'Pay Interest'              },
                  8  => { output: 'Add Account'               },
                  9  => { output: 'Show Customers Accounts'   },
                  10 => { output: 'View Account Transactions' }  }

  ACCOUNT_TYPES = {  1 => { output: :Current  },
                     2 => { output: :Savings  },
                     3 => { output: :Business },
                     4 => { output: :IR       },
                     5 => { output: :SMB      },
                     6 => { output: :Student  }  }

  def initialize
    @controller = Controller.new
  end

  def start
    show(MENU_ITEMS)
    input = verify(gets.chomp.to_i, with: MENU_ITEMS)
    select_option(input)
  end

  private

  def verify(input, with:)
    until with.key? input
      puts_with_sleep 'Unrecognised option, try again...'
      show(with)
      input = gets.chomp.to_i
    end
    input
  end

  def create_holder
    puts 'Enter Name and Press Enter'
    name = gets.chomp
    response = @controller.create_holder name
    puts response
  end

  def create_account
    show(ACCOUNT_TYPES)
    input = verify(gets.chomp.to_i, with: ACCOUNT_TYPES)
    type = ACCOUNT_TYPES[input][:output]
    puts_with_sleep 'Enter Holder ID'
    holder_id = gets.chomp.to_i
    response = @controller.open_account(type, with: holder_id)
    puts response
  end

  def puts_with_sleep(string)
    puts string
    sleep(0.5)
  end

  def show(list)
    list.each { |key, value| puts_with_sleep "#{key}. #{value[:output]}" }
    puts_with_sleep 'Make a selection and Press Enter'
  end

  def select_option(input)
    create_holder  if input == 1
    create_account if input == 2
    deposit if input == 3
    start
  end
end

test = Boundary.new
test.start
