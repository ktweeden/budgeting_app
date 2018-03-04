require 'pg'

class SqlRunner

  def self.run(sql, values = [])
    db_name = ENV['DB_NAME'].nil? ? 'budget' : ENV['DB_NAME']
    db_host = ENV['DB_HOST'].nil? 'localhost' : ENV['DB_HOST']
    begin
     db = PG.connect({dbname: db_name, host: db_host})
     db.prepare('query', sql)
     return result = db.exec_prepared('query', values)
   ensure
     db.close
   end
  end
end
