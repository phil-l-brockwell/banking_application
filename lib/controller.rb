# Definition of Controller Class
class Controller
  attr_reader :name, :accounts, :holders

  def initialize
    @accounts = []
    @holders = {}
    @main_items =   { 0 => 'Create New Holder',
                      1 => 'Create Current Account',
                      2 => 'Deposit',
                      3 => 'Display Balance',
                      4 => 'Withdraw',
                      5 => 'Transfer Money',
                      6 => 'Pay Interest',
                      7 => 'Add Account Holder',
                      8 => 'Show all accounts held by a customer',
                      9 => 'View Transactions' }
    @account_types = ['Current',
                      'Savings',
                      'Student',
                      'Business',
                      'SMB',
                      'IR']
  end

  def add_holder(new_holder)
    @holders.any? ? id = @holders.length + 1 : id = 0
    new_holder.add_id(id)
    @holders[id] = new_holder
  end

  def add_account(new_account)
    @accounts << new_account
  end

  def enter
    input = nil
    until input == ''
      puts "Press 'ENTER' to begin"
      input = gets.chomp
    end
  end

  def main_menu
    @main_items.each { |key, value | puts "#{key}: #{value}" }
    puts "What would you like to do?\nEnter a number and hit 'ENTER'"
    gets.chomp
  end

  def option_0
    puts 'Enter Customer Name'
    name = gets.chomp
    add_holder(new_holder)
    puts 'Holder added!'
  end

  def option_1
      puts 'Enter customer ID'
      puts 'Which type of account would you like to open?'
      @account_types.each_with_index { |account, index| puts "#{index}. #{account} Account" }
      account = gets.chomp.to_i
      puts ''
  end

  def selector(input)
    case input
    when 0 then option_0
    when 1 then option_1
    when 2 then option_2
    when 3 then option_3
    when 4 then option_4
    when 5 then option_5
    when 6 then option_6
    when 7 then option_7
    when 8 then option_8
    when 9 then option_9
    end
  end

  def start
    enter
    input = main_menu.to_i
    selector(input)
  end
end
