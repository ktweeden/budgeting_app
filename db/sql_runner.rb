require 'pg'

class SqlRunner

  def self.run(sql, values)
    begin
     db = PG.connect({dbname: 'budget', host: 'localhost'})
     db.prepare('query', sql)
     return result = db.exec_prepared('query', values)
   ensure
     db.close
   end
  end
end
