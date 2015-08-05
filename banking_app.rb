require 'sinatra/base'
# requires sinatra gem
# sinatra is a light weight ruby web framework
# designed to be simple to use to quickly get small web apps up and running
require 'tilt/erb'
# used for templating html/erb pages
require 'require_all'
# gem to require a directory of file as opposed to one file at a time
require_all 'lib'
# requires entire library dir
require 'rufus-scheduler'
# requires task scheduling gem

# Class Banking App, defines logic and routes for Sinatra Web App
class BankingApp < Sinatra::Base
  # contains a reference to each controller so appropriate methods can be called
  accounts = AccountsController.instance
  holders  = HoldersController.instance
  loans    = LoansController.instance

  # the following blocks tell the app what to do when a post/get request is made to the route specified
  # the last line of each method must tell the app to render a erb/html page
  # any @/instance variables used in a block can also be accessed inside the erb/html page
  # params that have been passed with get/post requests can be accessed calling the params hash with the appropriate id
  # responsibilites are taking input from html page and calling controller methods, then returning results, and repeating

  get '/' do
    erb :index
  end

  get '/holders' do
    @holders = holders.store
    erb :holders
  end

  get '/holders_accounts' do
    @holder = holders.find(params[:id])
    message = accounts.get_accounts_of(params[:id])
    @accounts = message.accounts
    erb :accounts
  end

  get '/new_holder' do
    erb :new_holder
  end

  post '/new_holder' do
    @message = holders.create(params[:name])
    @holders = holders.store
    erb :holders
  end

  get '/create_account' do
    erb :create_account
  end

  post '/create_account' do
    @message = accounts.open(params[:type], with: params[:id])
    @accounts = accounts.store.values
    erb :accounts
  end

  get '/accounts' do
    @accounts = accounts.store.values
    erb :accounts
  end

  get '/transactions' do
    message = accounts.get_transactions_of(params[:id])
    @transactions = message.transactions
    erb :transactions
  end

  get '/deposit' do
    erb :deposit
  end

  post '/deposit' do
    @accounts = accounts.store.values
    @message = accounts.deposit(params[:amount], into: params[:id])
    erb :accounts
  end

  get '/withdraw' do
    erb :withdraw
  end

  post '/withdraw' do
    @accounts = accounts.store.values
    @message = accounts.withdraw(params[:amount], from: params[:id])
    erb :accounts
  end

  get '/transfer' do
    erb :transfer
  end

  post '/transfer' do
    @accounts = accounts.store.values
    @message = accounts.transfer(params[:amount], from: params[:donar], to: params[:recipitent])
    erb :accounts
  end

  get '/add_holder' do
    erb :add_holder
  end

  post '/add_holder' do
    @accounts = accounts.store.values
    @message = accounts.add_holder(params[:holder_id], to: params[:account_id])
    erb :accounts
  end

  get '/enable_overdraft' do
    erb :enable_overdraft
  end

  post '/enable_overdraft' do
    @accounts = accounts.store.values
    @message = accounts.activate_overdraft(params[:id], params[:amount])
    erb :accounts
  end

  get '/disable_overdraft' do
    erb :disable_overdraft
  end

  post '/disable_overdraft' do
    @accounts = accounts.store.values
    @message = accounts.deactivate_overdraft(params[:id])
    erb :accounts
  end

  get '/loans' do
    @loans = loans.store
    erb :loans
  end

  get '/loan_view' do
    message = loans.show(params[:id])
    @transactions = message.transactions
    erb :transactions
  end

  get '/new_loan' do
    erb :new_loan
  end

  post '/new_loan' do
    @loans = loans.store
    @message = loans.create_loan(params[:id], params[:amount], params[:term], params[:rate])
    erb :loans
  end

  get '/pay_loan' do
    erb :pay_loan
  end

  post '/pay_loan' do
    @message = loans.pay(params[:amount], off: params[:id])
    @loans = loans.store
    erb :loans
  end

  get '/tasks' do
    @tasks = accounts.task_manager.jobs
    erb :tasks
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
