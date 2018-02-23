require_relative '../db/sql_runner'


class Tag

  attr_reader :id, :name

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
    WHERE id = $1;"
    values = [@id]
    result = SqlRunner.run(sql, values).first['sum'].to_i
    result/100.0
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
