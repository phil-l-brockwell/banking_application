require 'require_all'
require_all 'lib'
require 'rufus-scheduler'
# Definition of Boundary Class
class Boundary

  attr_accessor :accounts, :holders

  MENU_ITEMS = { 1 => { op: :op_1, output: 'Create New Holder'         },
                 2 => { op: :op_2, output: 'Create an Account'         },
                 3 => { op: :op_3, output: 'Make a Deposit'            },
                 4 => { op: :op_4, output: 'Display Account Balance'   },
                 5 => { op: :op_5, output: 'Make a Withdrawal'         },
                 6 => { op: :op_6, output: 'Make a Transfer'           },
                 7 => { op: :op_7, output: 'Add Holder'                },
                 8 => { op: :op_8, output: 'Show Customers Accounts'   },
                 9 => { op: :op_9, output: 'View Account Transactions' } }

  ACCOUNT_TYPES = { 1  => { output: :Current      },
                    2  => { output: :Savings      },
                    3  => { output: :Business     },
                    4  => { output: :IR           },
                    5  => { output: :SMB          },
                    6  => { output: :Student      },
                    7  => { output: :HighInterest },
                    8  => { output: :Islamic      },
                    9  => { output: :Private      },
                    10 => { output: :LCR          } }

  def initialize
    @accounts = AccountsController.instance
    @holders = HoldersController.instance
  end

  def start
    show(MENU_ITEMS)
    input = verify(gets.chomp.to_i, with: MENU_ITEMS)
    message = send MENU_ITEMS[input][:op]
    puts_with_sleep message.output
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
    holders.create gets.chomp.capitalize
  end

  def op_2
    show(ACCOUNT_TYPES)
    input = verify(gets.chomp.to_i, with: ACCOUNT_TYPES)
    type = ACCOUNT_TYPES[input][:output]
    puts_with_sleep 'Enter Holder ID'
    holder_id = gets.chomp.to_i
    accounts.open_account(type, with: holder_id)
  end

  def op_3
    puts_with_sleep 'Enter Account ID to deposit into and Press Enter'
    id = gets.chomp.to_i
    return InvalidAccountMessage.new(id) unless accounts.exist? id
    puts_with_sleep 'Enter Amount you would like to Deposit and Press Enter'
    amount = gets.chomp.to_i
    accounts.deposit amount, into: id
  end

  def op_4
    puts_with_sleep 'Enter Account ID and Press Enter'
    id = gets.chomp.to_i
    return InvalidAccountMessage.new(id) unless accounts.exist? id
    accounts.get_balance_of id
  end

  def op_5
    puts_with_sleep 'Enter Account ID to withdraw from and Press Enter'
    account_id = gets.chomp.to_i
    puts_with_sleep 'Enter Amount you would like to Withdraw and Press Enter'
    amount = gets.chomp.to_i
    accounts.withdraw amount, from: account_id
  end

  def op_6
    puts_with_sleep 'Enter Account ID to transfer from and Press Enter'
    donar_id = gets.chomp.to_i
    puts_with_sleep 'Enter Account ID to transfer to and Press Enter'
    recipitent_id = gets.chomp.to_i
    puts_with_sleep 'Enter Amount you would like to transfer'
    amount = gets.chomp.to_i
    accounts.transfer amount, from: donar_id, to: recipitent_id
  end

  def op_7
    puts_with_sleep 'Enter Account ID to Add a Holder to and Press Enter'
    account_id = gets.chomp.to_i
    puts_with_sleep 'Enter Holder ID you wish to add and Press Enter'
    new_holder_id = gets.chomp.to_i
    accounts.add_holder new_holder_id, to_account: account_id
  end

  def op_8
    puts_with_sleep 'Enter Holder ID to View Accounts of and Press Enter'
    accounts.get_accounts_of gets.chomp.to_i
  end

  def op_9
    puts_with_sleep 'Enter Account ID to View Transactions for and Press Enter'
    accounts.get_transactions_of gets.chomp.to_i
  end

  def puts_with_sleep(string)
    puts string
    sleep(0.2)
  end

  def show(list)
    list.each { |key, value| puts_with_sleep "#{key}. #{value[:output]}" }
    puts_with_sleep 'Make a selection and Press Enter'
  end
end

test = Boundary.new
test.start
