require_relative '../models/transaction'
require_relative '../models/tag'
require_relative '../models/merchant'
require_relative '../models/utils'
require_relative '../models/budget'


get '/tags/:id' do
  @date = Date.today
  @month = @date.strftime("%m")
  @year = @date.strftime("%Y")
  @tag = Tag.find_by_id(params['id'])
  @transactions = @tag.transactions
  @budget = @tag.budget
  @budget_info = @budget.month_spending_info(@month, @year) if @budget != nil
  @monthly = @tag.previous_3_months_spending_info
  erb(:"tags/tag")
end

get '/tags' do
  @date = Date.today
  @month = @date.strftime("%m")
  @year = @date.strftime("%Y")
  @tags = Tag.all
  @tag_budgets = Budget.all_tag_budgets.map {|budget| budget.month_spending_info(@month, @year)}
  @tags_this_month =  Tag.all_for_month(@month, @year).first(3)
  erb(:"tags/all")
end
