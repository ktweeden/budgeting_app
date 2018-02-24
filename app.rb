require 'sinatra'
require 'sinatra/contrib/all'
require_relative 'contollers/transaction'
require_relative 'contollers/tag'
require_relative 'contollers/merchant'


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

get '/merchants' do
  @merchants = Merchant.all
  erb(:"merchants/all")
end

post '/add/transaction' do
  transaction = Transaction.new(params)
  transaction.save
  redirect '/'
end
