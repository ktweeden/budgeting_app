require 'sinatra'
require 'sinatra/contrib/all'
require_relative 'controllers/transaction_controller'
require_relative 'controllers/tag_controller'
require_relative 'controllers/merchant_controller'
require_relative 'controllers/analytic_controller'
require_relative 'controllers/budget_controller'
require 'pry'


get '/' do
  @transactions = Transaction.all
  erb(:home)
end
