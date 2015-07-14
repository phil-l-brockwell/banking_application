require 'singleton'
require 'require_all'
require_all 'lib'
require 'rufus-scheduler'
require 'colorize'
# Definition of Boundary Class
class Boundary
  include Singleton
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
                 12 => { op: :op_12, output: 'Make Loan Payment'         },
                 13 => { op: :op_13, output: 'Enable/Edit Overdraft'     },
                 14 => { op: :op_14, output: 'Disable Overdraft'         },
                 15 => { op: :op_15, output: 'View Overdraft Status'     } }

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
    @accounts  = AccountsController.instance
    @holders   = HoldersController.instance
    @loans     = LoansController.instance
  end

  def render(message)
    say message.output, message.colour
    start
  end

  def start
    show(MENU_ITEMS)
    input = verify(gets.chomp, with: MENU_ITEMS)
    send MENU_ITEMS[input][:op]
  end

  private

  def op_1
    say 'Enter Name'
    holders.create gets.chomp
  end

  def op_2
    show(ACCOUNT_TYPES)
    input = verify(gets.chomp, with: ACCOUNT_TYPES)
    type = ACCOUNT_TYPES[input][:output]
    accounts.open type, with: get_('holder id')
  end

  def op_3
    accounts.deposit get_('amount'), into: get_('account id')
  end

  def op_4
    accounts.get_balance_of get_('account id')
  end

  def op_5
    accounts.withdraw get_('amount'), from: get_('account id')
  end

  def op_6
    accounts.transfer get_('amount'), from: get_('donar id'), to: get_('recipitent id')
  end

  def op_7
    accounts.add_holder get_('holder id'), to: get_('account id')
  end

  def op_8
    accounts.get_accounts_of get_('holder id')
  end

  def op_9
    accounts.get_transactions_of get_('account id')
  end

  def op_10
    options = { borrowed: get_('amount'), term: get_('term') }
    say 'Enter the Interest Rate'
    options[:rate] = gets.chomp.to_f
    loans.create_loan get_('holder id'), options
  end

  def op_11
    loans.show get_('loan id')
  end

  def op_12
    loans.pay get_('amount'), off: get_('loan id')
  end

  def op_13
    accounts.activate_overdraft get_('account id'), get_('amount')
  end

  def op_14
    accounts.deactivate_overdraft get_('account id')
  end

  def op_15
    accounts.show_overdraft get_('account id')
  end

  def say(output, colour=:blue)
    puts output.colorize(colour) if output.is_a? String
    output.each { |string| puts string.colorize(colour) } if output.is_a? Array
    sleep(0.2)
  end

  def show(list)
    list.each { |key, value| say "#{key}. #{value[:output]}" }
    say "Make a selection or type 'exit' to quit."
  end

  def verify(input, with:)
    until with.key? input.to_i
      abort('Have a Nice Day!') if input == 'exit'
      say 'Unrecognised option, try again.'
      show(with)
      input = gets.chomp
    end
    input.to_i
  end

  def get_(input)
    say "Enter the #{input.capitalize}"
    gets.chomp.to_i
  end
end

Boundary.instance.start
