require 'sinatra/base'
require 'tilt/erb'
require 'require_all'
require_all 'lib'
require 'rufus-scheduler'

class BankingApp < Sinatra::Base

  accounts = AccountsController.instance
  holders  = HoldersController.instance
  loans    = LoansController.instance

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
    type = params[:type]
    id = params[:id]
    @message = accounts.open(type, with: id)
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

  # start the server if ruby file executed directly
  run! if app_file == $0
end
