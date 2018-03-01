require_relative '../models/transaction'
require_relative '../models/tag'
require_relative '../models/merchant'
require_relative '../models/utils'
require_relative '../models/budget'


get '/merchants/:id' do
  @merchant = Merchant.find_by_id(params['id'])
  @transactions = @merchant.transactions
  erb(:"merchants/merchant")
end

get '/merchants' do
  @date = Date.today
  @month = @date.strftime("%m")
  @year = @date.strftime("%Y")
  @merchants = Merchant.all
  @merchants_this_month =  Merchant.all_for_month(@month, @year).first(3)
  erb(:"merchants/all")
end

get '/add/merchant' do
  erb(:"merchants/add")
end

post '/add/merchant' do
  sanitized_name = sanitize(params['name'])
  redirect '/merchants' if Merchant.find_by_name(sanitised_name) != nil
  merchant = Merchant.new({'name' => sanitised_name})
  merchant.save
  redirect '/merchants'
end
