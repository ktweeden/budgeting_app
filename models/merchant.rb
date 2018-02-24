require_relative '../db/sql_runner'

class Merchant

  attr_reader :id, :name
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save
    sql = "INSERT INTO merchants
    (
      name
    )
    VALUES (
      $1
    ) RETURNING *;"
    values = [@name]
    result = SqlRunner.run(sql, values).first
    @id = Merchant.new(result).id
  end

  def update
    sql = "UPDATE merchants
    SET name = $1
    WHERE id = $2
    RETURNING *;"
    values = [@name, @id]
    result = SqlRunner.run(sql, values).first
    Merchant.new(result)
  end

  def delete
    sql = "DELETE FROM merchants WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def transactions
    sql = "SELECT * FROM transactions WHERE merchant_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    results.map {|transaction| Transaction.new(transaction)}
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM merchants WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, values).first
    Merchant.new(result)
  end

  def self.all
    sql = "SELECT * FROM merchants";
    results = SqlRunner.run(sql)
    results.map {|merchant| Merchant.new(merchant)}
  end

end
