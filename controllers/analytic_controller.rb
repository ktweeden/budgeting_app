require_relative '../models/transaction'
require_relative '../models/tag'
require_relative '../models/merchant'
require_relative '../models/utils'

get '/analytics/[:month]/[:year]' do
  @transactions = Transaction.by_month(params['month'], params['year'])
  @month = "#{params['month']}, #{params['year']}"
  erb(:"analytics/month")
end
