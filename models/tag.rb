require_relative '../db/sql_runner'


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

  def transactions
    sql = "SELECT amount, to_char(dt, 'DD-MM-YYYY') AS dt, merchant_id, tag_id
    FROM transactions
    WHERE tag_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    results.map {|transaction| Transaction.new(transaction)}
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM tags WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    Tag.new(result)
  end

  def self.all
    sql = "SELECT * FROM tags"
    results = SqlRunner.run(sql)
    results.map {|tag| Tag.new(tag)}
  end

end
