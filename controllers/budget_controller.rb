require_relative '../models/transaction'
require_relative '../models/tag'
require_relative '../models/merchant'
require_relative '../models/utils'
require_relative '../models/budget'


get '/budgets' do
  @date = Date.today
  @month = @date.strftime("%m")
  @year = @date.strftime("%Y")
  @main_budget = Budget.main_budget.month_spending_info(@month, @year)
  @tag_budgets = Budget.all_tag_budgets
  @tag_budget_info = Budget.all_tag_budgets.map {|budget| budget.month_spending_info(@month, @year)}
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
  @tags = Tag.without_budgets
  erb(:"budgets/add")
end

get '/budgets/delete/:id' do
  @budget = Budget.find_by_id(params['id'])
  @budget.delete
  redirect '/budgets'
end

post '/budgets/add' do
   budget_hash = {
     'amount' => to_pennies(params['amount']),
     'tag_id' => params['tag_id']
   }
   new_budget = Budget.new(budget_hash)
   new_budget.save
   redirect '/budgets'
end
