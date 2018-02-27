require_relative '../models/transaction'
require_relative '../models/tag'
require_relative '../models/merchant'
require_relative '../models/utils'
require_relative '../models/budget'
require 'pry'


get '/budgets' do
  @main = Budget.main_budget
  @tag_budgets = Budget.all_tag_budgets
  erb(:"budgets/all")
end

get '/budgets/update/main' do
  @budget = Budget.main_budget
  erb(:"budgets/update_main")
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

get '/budgets/add' do
  @tags = Tag.all
  erb(:"budgets/add")
end

post '/budgets/add' do
   if Budget.find_by_tag_id(params['tag_id'].to_i) != nil
      redirect '/'
   else
     budget_hash = {
       'amount' => to_pennies(params['amount']),
       'tag_id' => params['tag_id']
     }
     new_budget = Budget.new(budget_hash)
     new_budget.save
     redirect '/budgets'
   end
  # params['amount'] = to_pennies(params['amount'])

end
