require_relative '../db/sql_runner'
require_relative 'utils'


class Tag

  attr_reader :id, :name
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save
    sql = "INSERT INTO tags (name)
    VALUES ($1) RETURNING *;"
    values = [@name]
    result = SqlRunner.run(sql, values).first
    @id = Tag.new(result).id
  end

  def total_spent
    sql = "SELECT SUM (amount)
    FROM transactions
    WHERE tag_id = $1;"
    values = [@id]
    result = SqlRunner.run(sql, values).first['sum'].to_i
  end

  def total_spent_by_month(month, year)
    sql = "SELECT SUM (amount)
    FROM transactions
    WHERE (EXTRACT (MONTH FROM dt), EXTRACT (YEAR FROM dt), tag_id)
    = ($1, $2, $3);"
    values = [month, year, @id]
    result = SqlRunner.run(sql, values).first['sum'].to_i
  end

  def update
    sql = "UPDATE tags
    SET name = $1
    WHERE id = $2
    RETURNING *;"
    values = [@name, @id]
    result = SqlRunner.run(sql, values).first
    Tag.new(result)
  end

  def delete
    sql = "DELETE FROM tags WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def budget
    sql = "SELECT * FROM budgets WHERE tag_id = $1;"
    values = [@id]
    result = SqlRunner.run(sql, values).first
    Budget.new(result) if result != nil
  end

  def transactions
    sql = "SELECT *
    FROM transactions
    WHERE tag_id = $1
    ORDER BY dt DESC;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    results.map {|transaction| Transaction.new(transaction)}
  end

  def spending_by_month(month, year)
    sql = "SELECT SUM(transactions.amount) AS amount FROM transactions
    WHERE (EXTRACT(MONTH FROM transactions.dt), EXTRACT (YEAR FROM transactions.dt), tag_id) = ($1, $2, $3)
    GROUP BY tag_id
    ORDER BY SUM (transactions.amount) DESC;"
    values = [month, year, @id]
    if SqlRunner.run(sql, values).first == nil
      return "0"
    else
      return SqlRunner.run(sql, values).first['amount']
    end
  end

  def previous_3_months_spending_info
    date = Date.today
    previousd1 = date << 1
    previousd2 = date << 2
    previousd3 = date << 3
    spent = [
      { 'month' => previousd1.strftime("%B"),
        'amount' => spending_by_month(previousd1.strftime("%m"), previousd1.strftime("%Y"))
      },
      {
        'month' => previousd2.strftime("%B"),
        'amount' => spending_by_month(previousd2.strftime("%m"), previousd2.strftime("%Y"))
      },
      {
        'month' => previousd3.strftime("%B"),
        'amount' => spending_by_month(previousd3.strftime("%m"), previousd3.strftime("%Y"))
      }
    ]
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM tags WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    Tag.new(result)
  end

  def self.all
    sql = "
    SELECT tags.name, tags.id FROM tags
    INNER JOIN transactions ON transactions.tag_id = tags.id
    GROUP BY tags.id
    ORDER BY SUM (transactions.amount) DESC;"
    results = SqlRunner.run(sql)
    results.map {|tag| Tag.new(tag)}
  end

  def self.all_for_month(month, year)
    sql = "
    SELECT tags.name, tags.id, SUM(transactions.amount) AS amount FROM tags
    INNER JOIN transactions ON transactions.tag_id = tags.id
    WHERE (EXTRACT(MONTH FROM transactions.dt), EXTRACT (YEAR FROM transactions.dt)) = ($1, $2)
    GROUP BY tags.id
    ORDER BY SUM (transactions.amount) DESC;"
    values = [month, year]
    results = SqlRunner.run(sql, values)
  end


  def self.without_budgets
    sql = "SELECT tags.name, tags.id FROM tags
    LEFT JOIN budgets ON budgets.tag_id = tags.id
    WHERE budgets.tag_id IS NULL;"
    results = SqlRunner.run(sql)
    results.map {|tag| Tag.new(tag)}
  end
end
