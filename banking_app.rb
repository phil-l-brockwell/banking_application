require 'sinatra/base'
require 'tilt/erb'
require 'require_all'
require_all 'lib'
require 'rufus-scheduler'

class BankingApp < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'

  accounts = AccountsController.instance
  holders = HoldersController.instance
  loans = LoansController.instance

  get '/' do
    session[:accounts] = accounts
    session[:holders]  = holders
    session[:loans]    = loans
    erb :index
  end

  get '/holders' do
    @holders = session[:holders].store
    erb :holders
  end

  get '/holders_accounts' do
    @holder = session[:holders].find(params[:id].to_i)
    message = session[:accounts].get_accounts_of(params[:id].to_i)
    @accounts = message.accounts
    erb :holders_accounts
  end

  get '/new_holder' do
    erb :new_holder
  end

  post '/new_holder' do
    @message = session[:holders].create(params[:name])
    @holders = session[:holders].store
    erb :holders
  end

  get '/create_account' do
    erb :create_account
  end

  post '/create_account' do
    type = :Current
    id = params[:id].to_i
    @message = session[:accounts].open(type, with: id)
    erb :index
  end

  get '/accounts' do
    @accounts = session[:accounts].store
    erb :accounts
  end

  get '/transactions' do
    message = session[:accounts].get_transactions_of(params[:id].to_i)
    @transactions = message.transactions
    erb :transactions
  end

  get '/deposit' do
    erb :deposit
  end

  post '/deposit' do
    @accounts = session[:accounts].store
    @message = session[:accounts].deposit(params[:amount].to_i, into: params[:id].to_i)
    erb :accounts
  end

  get '/withdraw' do
    erb :withdraw
  end

  post '/withdraw' do
    @accounts = session[:accounts].store
    @message = session[:accounts].withdraw(params[:amount].to_i, from: params[:id].to_i)
    erb :accounts
  end

  get '/transfer' do
    erb :transfer
  end

  post '/transfer' do
    @accounts = session[:accounts].store
    @message = session[:accounts].transfer(params[:amount].to_i, from: params[:donar].to_i, to: params[:recipitent].to_i)
    erb :accounts
  end

  get '/add_holder' do
    erb :add_holder
  end

  post '/add_holder' do
    @accounts = session[:accounts].store
    @message = session[:accounts].add_holder(params[:holder_id].to_i, to: params[:account_id].to_i)
    erb :accounts
  end

  get '/enable_overdraft' do
    erb :enable_overdraft
  end

  post '/enable_overdraft' do
    @accounts = session[:accounts].store
    @message = session[:accounts].activate_overdraft(params[:id].to_i, params[:amount].to_i)
    erb :accounts
  end

  get '/disable_overdraft' do
    erb :disable_overdraft
  end

  post '/disable_overdraft' do
    @accounts = session[:accounts].store
    @message = session[:accounts].deactivate_overdraft(params[:id].to_i)
    erb :accounts
  end

  get '/loans' do
    @loans = session[:loans].store
    erb :loans
  end

  get '/loan_view' do
    message = session[:loans].show(params[:id].to_i)
    @transactions = message.transactions
    erb :loan_view
  end

  get '/new_loan' do
    erb :new_loan
  end

  post '/new_loan' do
    @loans = session[:loans].store
    id = params[:id].to_i
    options = { borrowed: params[:amount].to_i, term: params[:term].to_i, rate: params[:rate].to_f }
    @message = session[:loans].create_loan(id, options)
    erb :loans
  end

  get '/pay_loan' do
    erb :pay_loan
  end

  post '/pay_loan' do
    @message = session[:loans].pay(params[:amount].to_i, off: params[:id].to_i)
    @loans = session[:loans].store
    erb :loans
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
