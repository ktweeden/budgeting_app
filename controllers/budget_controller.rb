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
