require 'pg'

class SqlRunner

  def self.run(sql, values = [])
    db_info = ENV['DATABASE_URL'].nil? ? {dbname: 'budget', host: 'localhost'} : ENV['DATABASE_URL']
    begin
     db = PG.connect(db_info)
     db.prepare('query', sql)
     return result = db.exec_prepared('query', values)
   ensure
     db.close
   end
  end
end
