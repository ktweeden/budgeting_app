require_relative '../models/transaction'
require_relative '../models/tag'
require_relative '../models/merchant'
require_relative '../models/utils'
require_relative '../models/budget'


get '/analytics/dashboard/:month/:year' do
  @date = Date.parse("#{params['month']}/#{params['year']}")
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

get '/spinning' do
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
  erb(:"analytics/dashboard-spins")
end

get '/spinning/more' do
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
  erb(:"analytics/dashboard-spins-more")
end
