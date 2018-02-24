require 'sinatra'
require 'sinatra/contrib/all'
require_relative 'models/transaction'
require_relative 'models/tag'
require_relative 'models/merchant'
require_relative 'models/utils'


get '/' do
  @transactions = Transaction.all
  erb(:home)
end

get '/add/transaction' do
  @merchants = Merchant.all
  @tags = Tag.all
  erb(:"transactions/add")
end

get '/merchants/:id' do
  @merchant = Merchant.find_by_id(params['id'])
  @transactions = @merchant.transactions
  erb(:"merchants/merchant")
end

post '/add/transaction' do
  transaction = Transaction.new(params)
  transaction.save
  redirect '/'
end
