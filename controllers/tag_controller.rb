require_relative '../models/transaction'
require_relative '../models/tag'
require_relative '../models/merchant'
require_relative '../models/utils'
require_relative '../models/budget'


get '/tags/:id' do
  @tag = Tag.find_by_id(params['id'])
  @transactions = @tag.transactions
  erb(:"tags/tag")
end

get '/tags' do
  @tags = Tag.all
  erb(:"tags/all")
end
