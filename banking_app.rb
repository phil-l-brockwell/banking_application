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
    @holder = holders.find(params[:id].to_i)
    message = accounts.get_accounts_of(params[:id].to_i)
    @accounts = message.accounts
    erb :holders_accounts
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
    type = :Current
    id = params[:id].to_i
    @message = accounts.open(type, with: id)
    erb :index
  end

  get '/accounts' do
    @accounts = accounts.store
    erb :accounts
  end

  get '/loans' do
    @loans = loans.store
    erb :loans
  end

  get '/new_loan' do
    erb :new_loan
  end

  get '/pay_loan' do
    erb :pay_loan
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
