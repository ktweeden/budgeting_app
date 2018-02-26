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

  def self.find_by_id(id)
    sql = "SELECT * FROM budgets WHERE id = $1";
    values = [id]
    result = SqlRunner.run(sql, values).first
    Budget.new(result)
  end

  def self.find_by_tag_id(tag_id)
    sql = "SELECT * FROM budgets WHERE tag_id = $1";
    values = [tag_id]
    result = SqlRunner.run(sql, values).first
    Budget.new(result)
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
