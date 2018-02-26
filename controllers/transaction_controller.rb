require_relative '../models/transaction'
require_relative '../models/tag'
require_relative '../models/merchant'
require_relative '../models/utils'
require_relative '../models/budget'


get '/add/transaction' do
  @merchants = Merchant.all
  @tags = Tag.all
  erb(:"transactions/add")
end

post '/add/transaction' do
  redirect '/' if is_negative?(params['amount'])
  redirect '/' if Time.parse(params['dt']) > Time.now
  pennies = to_pennies(params['amount'])
  transaction_hash = {
    'dt' => params['dt'],
    'amount' => pennies,
    'merchant_id' => params['merchant_id'],
    'tag_id' => params['tag_id']
  }
  transaction = Transaction.new(transaction_hash)
  transaction.save
  redirect '/'
end
