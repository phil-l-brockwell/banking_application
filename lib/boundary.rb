require 'require_all'
require_all 'lib'
require 'rufus-scheduler'
# Definition of Boundary Class
class Boundary
  attr_accessor :accounts, :holders, :loans

  MENU_ITEMS = { 1  => { op: :op_1,  output: 'Create New Holder'         },
                 2  => { op: :op_2,  output: 'Create an Account'         },
                 3  => { op: :op_3,  output: 'Make a Deposit'            },
                 4  => { op: :op_4,  output: 'Display Account Balance'   },
                 5  => { op: :op_5,  output: 'Make a Withdrawal'         },
                 6  => { op: :op_6,  output: 'Make a Transfer'           },
                 7  => { op: :op_7,  output: 'Add Holder'                },
                 8  => { op: :op_8,  output: 'Show Customers Accounts'   },
                 9  => { op: :op_9,  output: 'View Account Transactions' },
                 10 => { op: :op_10, output: 'New Loan'                  },
                 11 => { op: :op_11, output: 'View Loan'                 },
                 12 => { op: :op_12, output: 'Make Loan Payment'         } }

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
    @holders  = HoldersController.instance
    @loans    = LoansController.instance
  end

  def start
    show(MENU_ITEMS)
    input = gets.chomp
    input = verify(input, with: MENU_ITEMS)
    message = send MENU_ITEMS[input][:op]
    p_sleep message.output
    start
  end

  private

  def verify(input, with:)
    until with.key? input.to_i
      abort('Have a Nice Day!') if input == 'exit'
      p_sleep 'Unrecognised option, try again...'
      show(with)
      input = gets.chomp
    end
    input.to_i
  end

  def op_1
    p_sleep 'Enter Name'
    holders.create gets.chomp
  end

  def op_2
    p_sleep 'Enter Holder ID'
    id = gets.chomp.to_i
    return InvalidHolderMessage.new(id) unless holders.exist? id
    show(ACCOUNT_TYPES)
    input = verify(gets.chomp.to_i, with: ACCOUNT_TYPES)
    type = ACCOUNT_TYPES[input][:output]
    accounts.open type, with: id
  end

  def op_3
    p_sleep 'Enter Account ID'
    id = gets.chomp.to_i
    return InvalidAccountMessage.new(id) unless accounts.exist? id
    puts_with_sleep 'Enter Amount you would like to Deposit and Press Enter'
    amount = gets.chomp.to_i
    accounts.deposit amount, into: id
  end

  def op_4
    p_sleep 'Enter Account ID'
    id = gets.chomp.to_i
    return InvalidAccountMessage.new(id) unless accounts.exist? id
    accounts.get_balance_of id
  end

  def op_5
    p_sleep 'Enter Account ID'
    id = gets.chomp.to_i
    return InvalidAccountMessage.new(id) unless accounts.exist? id
    p_sleep 'Enter Amount you would like to Withdraw'
    amount = gets.chomp.to_i
    accounts.withdraw amount, from: id
  end

  def op_6
    p_sleep 'Enter Account ID to transfer from'
    donar_id = gets.chomp.to_i
    return InvalidAccountMessage.new(donar_id) unless holders.exist? donar_id
    p_sleep 'Enter Account ID to transfer to'
    rec_id = gets.chomp.to_i
    return InvalidAccountMessage.new(rec_id) unless holders.exist? rec_id
    p_sleep 'Enter Amount you would like to transfer'
    amount = gets.chomp.to_i
    accounts.transfer amount, from: donar_id, to: recipitent_id
  end

  def op_7
    p_sleep 'Enter Account ID'
    a_id = gets.chomp.to_i
    return InvalidAccountMessage.new(a_id) unless accounts.exist? a_id
    p_sleep 'Enter Holder ID you wish to add'
    h_id = gets.chomp.to_i
    return InvalidHolderMessage.new(h_id) unless holders.exist? h_id
    accounts.add_holder h_id, to: a_id
  end

  def op_8
    p_sleep 'Enter Holder ID to View Accounts of'
    id = gets.chomp.to_i
    return InvalidHolderMessage.new(id) unless holders.exist? id
    accounts.get_accounts_of id
  end

  def op_9
    p_sleep 'Enter Account ID'
    id = gets.chomp.to_i
    return InvalidAccountMessage.new(id) unless accounts.exist? id
    accounts.get_transactions_of id
  end

  def op_10
    p_sleep 'Enter Holder ID'
    id = gets.chomp.to_i
    return InvalidHolderMessage.new(id) unless holders.exist? id
    options = {}
    options[:holder] = holders.exist? id
    p_sleep 'Enter Amount to borrow'
    options[:borrowed] = gets.chomp.to_i
    p_sleep 'Enter the term to borrow over'
    options[:term] = gets.chomp.to_i
    p_sleep 'Enter the Interest Rate'
    options[:rate] = gets.chomp.to_i
    loans.create_loan options
  end

  def op_11
    p_sleep 'Enter Loan ID'
    id = gets.chomp.to_i
    return InvalidLoanMessage.new unless loans.exist? id
    loans.show id
  end

  def op_12
    p_sleep 'Enter Loan ID'
    id = gets.chomp.to_i
    return InvalidLoanMessage.new unless loans.exist? id
    p_sleep 'Enter Amount'
    amount = gets.chomp.to_i
    loans.pay amount, off: id
  end

  def p_sleep(string)
    puts string
    sleep(0.2)
  end

  def show(list)
    list.each { |key, value| p_sleep "#{key}. #{value[:output]}" }
    p_sleep "Make a selection or type 'exit' to quit."
  end
end

test = Boundary.new
test.start
