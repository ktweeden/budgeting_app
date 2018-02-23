require_relative '../db/sql_runner'

class Merchant

  attr_reader :id, :name

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

end
