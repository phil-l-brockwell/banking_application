require 'sinatra/base'
require 'tilt/erb'
require 'require_all'
require_all 'lib'
require 'rufus-scheduler'

class BankingApp < Sinatra::Base

  set :views, Proc.new { File.join(root, "..", "views") }

  accounts  = AccountsController.instance
  holders   = HoldersController.instance
  loans     = LoansController.instance

  get '/' do
    erb :index
  end

  get '/holders' do
    @holders = holders.store
    erb :holders
  end

  get '/holders_accounts' do
    @holder = holders.find(params[:id].to_i)
    @accounts = accounts.get_accounts_of(params[:id].to_i)
    erb :holders_accounts
  end

  get '/new_holder' do
    erb :new_holder
  end

  post '/new_holder' do
    holders.create(params[:name])
    erb :index
  end

  post '/create_account' do
    type = :Current
    id = params[:id].to_i
    accounts.open(type, with: id)
    erb :index
  end

  get '/accounts' do
    @accounts = accounts.store
    erb :accounts
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
