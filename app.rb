require 'sinatra'
require 'sinatra/contrib/all'
require_relative 'controllers/transaction_controller'
require_relative 'controllers/tag_controller'
require_relative 'controllers/merchant_controller'


get '/' do
  @transactions = Transaction.all
  erb(:home)
end
