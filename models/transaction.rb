require_relative '../db/sql_runner'

class Transaction

  attr_reader :id, :amount, :merchant_id, :tag_id, :date
  attr_accessor :amount

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @date = options['dt']
    @amount = options['amount'].to_i
    @merchant_id = options['merchant_id'].to_i
    @tag_id = options['tag_id'].to_i
  end

  def save
    sql = "INSERT INTO transactions
    (
      dt, amount, merchant_id, tag_id
    )
    VALUES
    (
      $1, $2, $3, $4
    )
    RETURNING *;"
    values = [@date, @amount, @merchant_id, @tag_id]
    result = SqlRunner.run(sql, values).first
    @id = Transaction.new(result).id
  end

  def update
    sql = "UPDATE transactions
    SET (
      dt, amount, merchant_id, tag_id
    ) = (
      $1, $2, $3, $4
    )
    WHERE id = $5
    RETURNING *;"
    values = [@date, @amount, @merchant_id, @tag_id, @id]
    result = SqlRunner.run(sql, values).first
    Transaction.new(result)
  end

  def delete
    sql = "DELETE FROM transactions WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all
    sql = "SELECT amount, to_char(dt, 'DD-MM-YYYY') AS dt, merchant_id, tag_id
    FROM transactions;"
    results = SqlRunner.run(sql)
    results.map {|transaction| Transaction.new(transaction)}
  end

  def self.total_spent
    sql = "SELECT SUM (amount) FROM transactions;"
    SqlRunner.run(sql).first['sum'].to_i
  end

end
