

class User

   def self.find_by_id(id)
        user_data = QuestionsDatabase.get_first_row(<<-SQL, id: id)
        SELECT
            users.*
        FROM
            users
        WHERE
            users.id = :id
            SQL
            user_data.nil? ? nil : User.new(user_data)
   end

   def self.find_by_name(fname, lname)
        attrs = {fname: fname, lname: lname}
        user_data = QuestionsDatabase.get_first_row(<<-SQL, attrs)
        SELECT
            users.*
        FROM
            users
        WHERE
            users.fname = :fname AND users.lname = :lname
            SQL
   end

    attr_reader :id
    attr_accessor :fname, :lname

    def initialize(options = {})
        @id, @fname, @lname = options.values_at('id', 'fname', 'lname')
    end

  

    
end