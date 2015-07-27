require 'require_all'
require_all 'lib'
require 'rufus-scheduler'
require 'colorize'
# Definition of Boundary Class
class Boundary

  def initialize
    @accounts = AccountsController.instance
    @holders  = HoldersController.instance
    @loans    = LoansController.instance
    @account_types = accounts.types
    @holders_menu = { 1 => { op: -> { @holders.create get_('name') }, 
                             output: 'Create New Holder'          } }

    @overdrafts_menu = { 1 => { op: -> { @accounts.activate_overdraft get_('account id'), get_('amount') }, 
                                output: 'Enable/Edit Overdraft'                                           },
                         2 => { op: -> { @accounts.deactivate_overdraft get_('account id')               }, 
                                output: 'Disable Overdraft'                                               },
                         3 => { op: -> { @accounts.show_overdraft get_('account id')                     }, 
                                output: 'View Overdraft Status'                                           } }

    @loans_menu = { 1 => { op: -> { @loans.create_loan get_('holder id'), get_('amount'), get_('term'), get_('rate') }, 
                           output: 'New Loan'          },
                    2 => { op: -> { @loans.show get_('loan id') }, 
                           output: 'View Loan'         },
                    3 => { op: -> { @loans.pay get_('amount'), off: get_('loan id') }, 
                           output: 'Make Loan Payment' } }

    @accounts_menu = { 1 => { op: -> { @account_types.each { |key, _| say key.to_s }
                                       @accounts.open get_('type'), with: get_('holder id') }, 
                              output: 'Create an Account'         },
                       2 => { op: -> { @accounts.deposit get_('amount'), into: get_('account id') }, 
                              output: 'Make a Deposit'            },
                       3 => { op: -> { @accounts.get_balance_of get_('account id') }, 
                              output: 'Display Account Balance'   },
                       4 => { op: -> { @accounts.withdraw get_('amount'), from: get_('account id') },  
                              output: 'Make a Withdrawal'         },
                       5 => { op: -> { @accounts.transfer get_('amount'), from: get_('donar id'), to: get_('recipitent id') }, 
                              output: 'Make a Transfer'           },
                       6 => { op: -> { @accounts.add_holder get_('holder id'), to: get_('account id') }, 
                              output: 'Add Holder'                },
                       7 => { op: -> { @accounts.get_accounts_of get_('holder id') },  
                              output: 'Show Customers Accounts'   },
                       8 => { op: -> { @accounts.get_transactions_of get_('account id') }, 
                              output: 'View Account Transactions' } }

    @main_menu = { 1 => { menu: @holders_menu,    output: 'Holders'    },
                   2 => { menu: @accounts_menu,   output: 'Accounts'   },
                   3 => { menu: @loans_menu,      output: 'Loans'      },
                   4 => { menu: @overdrafts_menu, output: 'Overdrafts' } }
  end

  def start
    input = verify(@main_menu)
    menu = @main_menu[input][:menu]
    input = verify(menu)
    message = menu[input][:op].call
    say message.output, message.colour
    start
  end

  private

  def say(output, colour = :blue)
    puts output.colorize(colour) if output.is_a? String
    output.each { |string| puts string.colorize(colour) } if output.is_a? Array
    sleep(0.1)
  end

  def show(list)
    list.each { |key, value| say "#{key}. #{value[:output]}" }
    say "Make a selection, type 'exit' to quit, or 'main' to return to main menu."
  end

  def verify(menu)
    show menu
    input = gets.chomp
    until menu.key? input.to_i
      abort('Have a Nice Day!') if input == 'exit'
      abort(start) if input == 'main'
      say 'Unrecognised option, try again.'
      show menu
      input = gets.chomp
    end
    input.to_i
  end

  def get_(input)
    say "Enter the #{input.capitalize}"
    gets.chomp
  end
end

Boundary.new.start
