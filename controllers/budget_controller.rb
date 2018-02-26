require_relative '../models/transaction'
require_relative '../models/tag'
require_relative '../models/merchant'
require_relative '../models/utils'
require_relative '../models/budget'


get '/budgets' do
  @main = Budget.main_budget
  @tag_budgets = Budget.all_tag_budgets
  erb(:"budgets/all")
end

get '/budgets/update/:id' do
  @budget = Budget.find_by_id(params['id'])
  @tags = Tag.all
  erb(:"budgets/update")
end

post '/budgets/update/:id' do
  params['amount'] = to_pennies(params['amount'])
  new_budget = Budget.new(params)
  new_budget.update
  redirect '/budgets'
end
