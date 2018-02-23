require_relative '../db/sql_runner'

class Transaction

  attr_reader :id, :amount, :merchant_id, :tag_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @amount = options['amount'].to_i
    @merchant_id = options['merchant_id'].to_i
    @tag_id = options['tag_id'].to_i
  end

  def save
    sql = "INSERT INTO transactions
    (
      amount, merchant_id, tag_id
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING *;"
    values = [@amount, @merchant_id, @tag_id]
    result = SqlRunner.run(sql, values).first
    @id = Transaction.new(result).id
  end

  def self.all
    sql = "SELECT * FROM transactions;"
    results = SqlRunner.run(sql)
    results.map {|transaction| Transaction.new(transaction)}
  end

  def self.total_spent
    sql = "SELECT SUM (amount) FROM transactions;"
    result = SqlRunner.run(sql).first['sum'].to_i
    result/100.0
  end

end
