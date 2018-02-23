require_relative '../db/sql_runner'

class Transaction

  attr_reader :id, :amount, :merchant_id, :tag_id
  attr_accessor :amount

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

  def update
    sql = "UPDATE transactions
    SET (
      amount, merchant_id, tag_id
    ) = (
      $1, $2, $3
    )
    WHERE id = $4
    RETURNING *;"
    values = [@amount, @merchant_id, @tag_id, @id]
    result = SqlRunner.run(sql, values).first
    Transaction.new(result)
  end

  def delete
    sql = "DELETE FROM transactions WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
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
