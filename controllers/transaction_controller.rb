require_relative 'models/transaction'
require_relative 'models/tag'
require_relative 'models/merchant'
require_relative 'models/utils'


get '/add/transaction' do
  @merchants = Merchant.all
  @tags = Tag.all
  erb(:"transactions/add")
end

post '/add/transaction' do
  transaction = Transaction.new(params)
  transaction.save
  redirect '/'
end
