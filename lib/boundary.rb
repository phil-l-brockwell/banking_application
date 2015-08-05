require 'require_all'
# ruby gem to require a directory of files as opposed to one file at a time
require_all 'lib'
# requires entire library
require 'rufus-scheduler'
# requires task scheduling gem
require 'colorize'
# require colorising gem to output text in different colours

# Definition of Boundary Class
# this class will be used to get relevant input from the user interface,
# inputs are then passed as args to controller methods
# the only logic that will take place in this class is to check that user are selecting one of the options they have been given
# all other logic will be delegated to the controller and models
class Boundary
  def initialize
    # initialises with an instance of each of the controllers so the appropriate methods can be called
    @accounts = AccountsController.instance
    @holders  = HoldersController.instance
    @loans    = LoansController.instance
    # the boundary also initializes with a set of menu hashes
    # each hash will contain a set of option
    # each option will have a key, and a nested hash
    # the nested hash contains an output symbol the user will be presented
    # and an op, which is a ruby proc
    # a ruby proc is a block of code that can be stored in a variable and called by using .call
    # when an option is selected by the user, .call will be called on it to run the code
    # which will call the controller method
    # this irradicates the need for lengthy if/else/case statements
    @holders_menu = { 1 => { op: -> { @holders.create get_(:name) },
                             output: :'Create New Holder'          } }

    @overdrafts_menu = { 1 => { op: -> { @accounts.activate_overdraft get_(:'account id'), get_(:amount) }, 
                                output: :'Enable/Edit Overdraft'                                           },
                         2 => { op: -> { @accounts.deactivate_overdraft get_(:'account id')               },
                                output: :'Disable Overdraft'                                               },
                         3 => { op: -> { @accounts.show_overdraft get_(:'account id')                     },
                                output: :'View Overdraft Status'                                           } }

    @loans_menu = { 1 => { op: -> { @loans.create_loan get_(:'holder id'), get_(:amount), get_(:'term in years'), get_(:rate) },
                           output: :'New Loan'          },
                    2 => { op: -> { @loans.show get_(:'loan id') },
                           output: :'View Loan'         },
                    3 => { op: -> { @loans.pay get_(:amount), off: get_(:'loan id') },
                           output: :'Make Loan Payment' } }

    @accounts_menu = { 1 => { op: -> { @accounts.types.each { |key, _| say key.to_s }
                                       @accounts.open get_(:type), with: get_(:'holder id') },
                              output: :'Create an Account'         },
                       2 => { op: -> { @accounts.deposit get_(:amount), into: get_(:'account id') },
                              output: :'Make a Deposit'            },
                       3 => { op: -> { @accounts.get_balance_of get_(:'account id') },
                              output: :'Display Account Balance'   },
                       4 => { op: -> { @accounts.withdraw get_(:amount), from: get_(:'account id') },
                              output: :'Make a Withdrawal'         },
                       5 => { op: -> { @accounts.transfer get_(:amount), from: get_(:'donar id'), to: get_(:'recipitent id') },
                              output: :'Make a Transfer'           },
                       6 => { op: -> { @accounts.add_holder get_(:'holder id'), to: get_(:'account id') },
                              output: :'Add Holder'                },
                       7 => { op: -> { @accounts.get_accounts_of get_(:'holder id') },
                              output: :'Show Customers Accounts'   },
                       8 => { op: -> { @accounts.get_transactions_of get_(:'account id') },
                              output: :'View Account Transactions' } }

    # main menu linking to each of the sub menus
    @main_menu = { 1 => { menu: @holders_menu,    output: :Holders    },
                   2 => { menu: @accounts_menu,   output: :Accounts   },
                   3 => { menu: @loans_menu,      output: :Loans      },
                   4 => { menu: @overdrafts_menu, output: :Overdrafts } }
  end

  # the start menu shows an overview of the entire program
  # a uses selects an input
  # boundary gathers that input and calls controller method
  # controller method returns a message
  # boundary displays that message
  def start
    input = verify(@main_menu)
    # calls the verify method passing @main_menu and sets the return value to local variable
    sub_menu = @main_menu[input][:menu]
    # uses the input variable to select the sub_menu
    input = verify(sub_menu)
    # calls the verify method passing sub_menu and sets the return value to local variable
    message = sub_menu[input][:op].call
    # uses the input variable to select relevant code from menu
    # calls this code and sets its return value to local message variable
    say message.output, message.colour
    @accounts.task_manager.jobs.each { |job| puts job.next_time }
    # calls say method and passes message as an arg to output outcome to user
    start
    # recursive method calls itself
  end

  # private area
  private

  # used to print output to screen for user
  def say(output, colour = :blue)
    # takes two args, output will be the output string
    # colour is the colour it prints in, defaults to blue if no arg is passed
    output = [output] if output.is_a? String
    # converts output to an array if it is not already
    output.each { |string| puts string.colorize(colour) }
    # outputs each string in array in its correct colour
    sleep(0.1)
    # pauses briefly to show text lines incrementally
  end

  # method to output a menu hash
  def show(menu)
    # outputs the menu with its key so it can be selected
    menu.each { |key, value| say "#{key}. #{value[:output]}" }
    # gives the user an instruction
    say "Make a selection, type 'exit' to quit, or 'main' to return to main menu."
  end

  # method to verify a menu input
  def verify(menu)
    # takes a menu as an arg
    show menu
    # outputs the menu
    input = gets.chomp
    # gets the input from the user, saves it to local variable
    until menu.key? input.to_i
      # loops until input as integer is valid
      abort('Have a Nice Day!') if input == 'exit'
      # exits the program and outputs the text id user input is 'exit'
      abort(start) if input == 'main'
      # exits the menu and runs start method if user input is 'main'
      say 'Unrecognised option, try again.'
      # gives the user an instruction
      show menu
      # outputs the menu
      input = gets.chomp
      # gets the input again
    end
    input.to_i
    # returns the input as an integer so the boundary can use it to call the next menu/op
  end

  # method to get an input
  def get_(input)
    # takes a string as an arg
    say "Enter the #{input.capitalize}"
    # gives the user an instruction
    gets.chomp
    # returns the users input so the boundary can pass it as an arg to controller method
  end
end

# Boundary.new.start
# creates a boundary object and calls the start method
