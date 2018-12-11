require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
    include singleton

    SQL_FILE = File.join(File.dirname(__FILE__), 'import_db.sql')
    DB_FILE = File.join(File.dirname(__FILE__), 'questions.db')

    def self.open
        @database = SQLite3::Database.new(DB_FILE)
        @database.results_as_hash = true
        @database.type_translation = true

    end

   def self.execute(*args)
        instance.execute(*args)
   end

    def self.get_first_row(*args)
        instance.get_first_row(*args)
    end

end
