require_relative '../models/transaction'
require_relative '../models/tag'
require_relative '../models/merchant'
require_relative '../models/utils'
require_relative '../models/budget'

get '/analytics/:month/:year' do
  @date = Date.parse("#{params['month']}/#{params['year']}")
  @transactions = Transaction.by_month(date)
  @month = date.strftime('%B %Y')
  @amount = Transaction.total_spent_by_month(date.strftime("%m"), date.strftime("%Y"))
  erb(:"analytics/month")
end

get '/analytics/budgets' do
  month = Date.today.strftime("%m")
  year = Date.today.strftime("%Y")
  @main_budget = Budget.main_budget.month_spending_info(month, year)
  @tag_budgets = Budget.all_tag_budgets.map {|budget| budget.month_spending_info(month, year)}
  erb(:"analytics/budgets")
end

get '/analytics/dashboard/:month/:year' do
  @date = Date.parse("#{params['month']}/#{params['year']}")
  @month = @date.strftime("%m")
  @year = @date.strftime("%Y")
  @main_budget = Budget.main_budget.month_spending_info(@month, @year)
  @tag_budgets = Budget.all_tag_budgets.map {|budget| budget.month_spending_info(@month, @year)}
  @transactions = Transaction.all.first(5)
  @tags = Tag.all_for_month(@month, @year).first(3)
  @merchants = Merchant.all_for_month(@month, @year).first(3)
  erb(:"analytics/dashboard")
end
