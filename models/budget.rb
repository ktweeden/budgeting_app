require_relative '../db/sql_runner'
require_relative 'utils'

class Budget

  attr_reader :id, :tag_id
  attr_accessor :amount

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @amount = options['amount'].to_i
    @tag_id = options['tag_id'].to_i if options['tag_id']
  end

  def save
    sql = "INSERT INTO budgets
    (amount, tag_id)
    VALUES ($1, $2)
    RETURNING *;"
    values = [@amount, @tag_id]
    result = SqlRunner.run(sql, values).first
    @id = Budget.new(result).id
  end

  def update
    sql = "UPDATE budgets
    SET ( amount, tag_id )=($1, $2)
    WHERE id = $3
    RETURNING * ;"
    values = [@amount, @tag_id, @id]
    result = SqlRunner.run(sql, values).first
    Budget.new(result)
  end

  def delete
    sql = "DELETE FROM budgets WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def tag
    sql = "SELECT * FROM tags WHERE id = $1;"
    values = [@tag_id]
    result = SqlRunner.run(sql, values).first
    Tag.new(result)
  end

  def month_spending_info(month, year)
    budget_hash = {
      'amount' => @amount,
      'spent' => total_spent_by_month(month, year),
      'remaining' => @amount - total_spent_by_month(month, year),
      'percentage' => ((total_spent_by_month(month, year)/@amount.to_f) * 100).round(0)
    }
    budget_hash['tag'] = Tag.find_by_id(@tag_id).name if @tag_id
    budget_hash
  end

  def total_spent_by_month(month, year)
    if @tag_id
      Tag.find_by_id(@tag_id).total_spent_by_month(month, year)
    else
      Transaction.total_spent_by_month(month, year)
    end
  end

  def previous_3_months_spending_info
    date = Date.today
    previousd1 = date << 1
    previousd2 = date << 2
    previousd3 = date << 3
    budget_array = [
      month_spending_info(previousd1.strftime("%m"), previousd1.strftime("%Y")),
      month_spending_info(previousd2.strftime("%m"), previousd2.strftime("%Y")),
      month_spending_info(previousd3.strftime("%m"), previousd3.strftime("%Y"))
    ]
    budget_array[0]['month'] = previousd1.strftime("%B")
    budget_array[1]['month'] = previousd2.strftime("%B")
    budget_array[2]['month'] = previousd3.strftime("%B")
    budget_array
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM budgets WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, values).first
    Budget.new(result)
  end

  def self.find_by_tag_id(tag_id)
    sql = "SELECT * FROM budgets WHERE tag_id = $1;"
    values = [tag_id]
    result = SqlRunner.run(sql, values).first
    return Budget.new(result) if result != nil
  end

  def self.all
    sql = "SELECT * FROM budgets;"
    results = SqlRunner.run(sql)
    results.map {|budget| Budget.new(budget)}
  end

  def self.main_budget
    sql = "SELECT * FROM budgets WHERE tag_id IS NULL;"
    result = SqlRunner.run(sql).first
    Budget.new(result)
  end

  def self.all_tag_budgets
    sql = "SELECT * FROM budgets WHERE tag_id IS NOT NULL;"
    results = SqlRunner.run(sql)
    results.map {|budget| Budget.new(budget)}
  end

end
