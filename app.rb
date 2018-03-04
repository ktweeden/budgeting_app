require 'sinatra'
require 'sinatra/contrib/all'
require_relative 'controllers/transaction_controller'
require_relative 'controllers/tag_controller'
require_relative 'controllers/merchant_controller'
require_relative 'controllers/analytic_controller'
require_relative 'controllers/budget_controller'

get '/' do
  @date = Date.today
  @month = @date.strftime("%m")
  @year = @date.strftime("%Y")
  @previous = [
    @date << 1,
    @date << 2,
    @date << 3
  ]
  @main_budget = Budget.main_budget.month_spending_info(@month, @year)
  @tag_budgets = Budget.all_tag_budgets.map {|budget| budget.month_spending_info(@month, @year)}
  @transactions = Transaction.all.first(5)
  @tags = Tag.all_for_month(@month, @year).first(3)
  @merchants = Merchant.all_for_month(@month, @year).first(3)
  erb(:"analytics/dashboard")
end
