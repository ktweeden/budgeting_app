require_relative '../models/transaction'
require_relative '../models/tag'
require_relative '../models/merchant'
require_relative '../models/utils'


get '/merchants/:id' do
  @merchant = Merchant.find_by_id(params['id'])
  @transactions = @merchant.transactions
  erb(:"merchants/merchant")
end

get '/merchants' do
  @merchants = Merchant.all
  erb(:"merchants/all")
end

get '/add/merchant' do
  erb(:"merchants/add")
end

post '/add/merchant' do
  sanitised_name = params['name'].downcase.capitalize
  merchant = Merchant.new({'name' => sanitised_name})
  merchant.save
  redirect '/merchants'
end
