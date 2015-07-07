require 'require_all'
require_all 'lib'
# Definition of Boundary Class
class Boundary
  MENU_ITEMS = { 1  => { method: :op_1,  output: 'Create New Holder'         },
                 2  => { method: :op_2,  output: 'Create an Account'         },
                 3  => { method: :op_3,  output: 'Make a Deposit'            },
                 4  => { method: :op_4,  output: 'Display Account Balance'   },
                 5  => { method: :op_5,  output: 'Make a Withdrawal'         },
                 6  => { method: :op_6,  output: 'Make a Transfer'           },
                 7  => { method: :op_7,  output: 'Pay Interest'              },
                 8  => { method: :op_8,  output: 'Add Holder'                },
                 9  => { method: :op_9,  output: 'Show Customers Accounts'   },
                 10 => { method: :op_10, output: 'View Account Transactions' }  }

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
    send MENU_ITEMS[input][:method]
    start
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

  def op_1
    puts 'Enter Name and Press Enter'
    name = gets.chomp
    message = @controller.create_holder name
    puts_with_sleep message.output
  end

  def op_2
    show(ACCOUNT_TYPES)
    input = verify(gets.chomp.to_i, with: ACCOUNT_TYPES)
    type = ACCOUNT_TYPES[input][:output]
    puts_with_sleep 'Enter Holder ID'
    holder_id = gets.chomp.to_i
    message = @controller.open_account(type, with: holder_id)
    puts_with_sleep message.output
  end

  def op_3
    puts_with_sleep 'Enter Account ID to deposit into and Press Enter'
    account_id = gets.chomp.to_i
    puts_with_sleep "Enter Amount you would like to Deposit and Press Enter"
    amount = gets.chomp.to_i
    message = @controller.deposit amount, into: account_id
    puts_with_sleep message.output
  end

  def op_4
    puts_with_sleep 'Enter Account ID and Press Enter'
    account_id = gets.chomp.to_i
    message = @controller.get_balance_of account_id
    puts_with_sleep message.output
  end

  def op_5
    puts_with_sleep 'Enter Account ID to withdraw from and Press Enter'
    account_id = gets.chomp.to_i
    puts_with_sleep 'Enter Amount you would like to Withdraw and Press Enter'
    amount = gets.chomp.to_i
    message = @controller.withdraw amount, from: account_id
    puts_with_sleep message.output
  end

  def puts_with_sleep(string)
    puts string
    sleep(0.5)
  end

  def show(list)
    list.each { |key, value| puts_with_sleep "#{key}. #{value[:output]}" }
    puts_with_sleep 'Make a selection and Press Enter'
  end
end

test = Boundary.new
test.start
