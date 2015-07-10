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
    say message.output
    start
  end

  private

  def verify(input, with:)
    until with.key? input.to_i
      abort('Have a Nice Day!') if input == 'exit'
      say 'Unrecognised option, try again.'
      show(with)
      input = gets.chomp
    end
    input.to_i
  end

  def get_holder_id
    say 'Enter Holder ID'
    id = gets.chomp.to_i
    until holders.exist? id
      say InvalidHolderMessage.new(id).output
      id = gets.chomp.to_i
    end
    id
  end

  def get_account_id
    say 'Enter Account ID'
    id = gets.chomp.to_i
    until accounts.exist? id
      say InvalidAccountMessage.new(id).output
      id = gets.chomp.to_i
    end
    id
  end

  def get_loan_id
    say 'Enter Loan ID'
    id = gets.chomp.to_i
    until loans.exist? id
      say InvalidLoanMessage.new(id).output
      id = gets.chomp.to_i
    end
    id
  end

  def get_amount
    say 'Enter Amount'
    gets.chomp.to_i
  end

  def op_1
    say 'Enter Name'
    holders.create gets.chomp
  end

  def op_2
    id = get_holder_id
    show(ACCOUNT_TYPES)
    input = verify(gets.chomp.to_i, with: ACCOUNT_TYPES)
    type = ACCOUNT_TYPES[input][:output]
    accounts.open type, with: id
  end

  def op_3
    id = get_account_id
    amount = get_amount
    accounts.deposit amount, into: id
  end

  def op_4
    id = get_account_id
    accounts.get_balance_of id
  end

  def op_5
    id = get_account_id
    amount = get_amount
    accounts.withdraw amount, from: id
  end

  def op_6
    say 'Donar Account'
    donar_id = get_account_id
    say 'Recipitent Account'
    rec_id = get_account_id
    amount = get_amount
    accounts.transfer amount, from: donar_id, to: rec_id
  end

  def op_7
    a_id = get_account_id
    h_id = get_user_id
    accounts.add_holder h_id, to: a_id
  end

  def op_8
    id = get_holder_id
    accounts.get_accounts_of id
  end

  def op_9
    id = get_account_id
    accounts.get_transactions_of id
  end

  def op_10
    id = get_holder_id
    options = {}
    options[:holder] = holders.exist? id
    options[:borrowed] = get_amount
    say 'Enter the term'
    options[:term] = gets.chomp.to_i
    say 'Enter the Interest Rate'
    options[:rate] = gets.chomp.to_f
    loans.create_loan options
  end

  def op_11
    id = get_loan_id
    loans.show id
  end

  def op_12
    id = get_loan_id
    amount = get_amount
    loans.pay amount, off: id
  end

  def say(string)
    puts string
    sleep(0.2)
  end

  def show(list)
    list.each { |key, value| say "#{key}. #{value[:output]}" }
    say "Make a selection or type 'exit' to quit."
  end
end

test = Boundary.new
test.start
