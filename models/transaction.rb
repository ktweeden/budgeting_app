require '../db/sql_runner'

class Transaction

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @amount = options['amount'].to_i
    @merchant_id = options['mercahnt_id'].to_i
    @tag_id = options['tag_id'].to_i
  end

end
