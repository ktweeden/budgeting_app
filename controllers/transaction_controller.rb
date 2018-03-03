require_relative '../models/transaction'
require_relative '../models/tag'
require_relative '../models/merchant'
require_relative '../models/utils'
require_relative '../models/budget'


get '/transactions' do
  @date = Date.today
  @month = @date.strftime("%m")
  @year = @date.strftime("%Y")
  @main_budget = Budget.main_budget.month_spending_info(@month, @year)
  @transactions = Transaction.all
  @previous = Budget.main_budget.previous_3_months_spending_info
  erb(:"transactions/all")
end

get '/add/transaction' do
  @merchants = Merchant.all
  @tags = Tag.all
  erb(:"transactions/add")
end

get '/add/transaction/negative' do
  @error = "Transaction amounts must be positive."
  @merchants = Merchant.all
  @tags = Tag.all
  erb(:"transactions/add")
end

get '/add/transaction/time' do
  @error = "Transaction date must be today or earlier."
  @merchants = Merchant.all
  @tags = Tag.all
  erb(:"transactions/add")
end

post '/add/transaction' do
  redirect '/add/transaction/negative' if is_negative?(params['amount'])
  redirect '/add/transaction/time' if Time.parse(params['dt']) > Time.now
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
