require 'sinatra/base'
require 'tilt/erb'
require 'require_all'
require_all 'lib'
require 'rufus-scheduler'

class BankingApp < Sinatra::Base

  accounts  = AccountsController.instance
  holders   = HoldersController.instance
  loans     = LoansController.instance

  get '/' do
    @holders = holders.store
    erb :index
  end

  get '/new_holder' do
    erb :new_holder
  end

  post '/new_holder' do
    @message = holders.create(params[:name])
    @holders = holders.store
    erb :index
  end

  get '/create_account' do
    erb :create_account
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
