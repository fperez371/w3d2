require_relative 'questions_database'
require_relative 'user'
require_relative 'question'

class Reply
    def self.find(id)
        reply_data = QuestionsDatabase.get_first_row(<<-SQL, id: id)
        SELECT
            replies.*
        FROM
            replies
        WHERE
            replies.id = :id
        SQL
        Reply.new(reply_data)
    end

    def self.find_by_parent_id(parent_id)
        replies_data = QuestionsDatabase.execute(<<-SQL, parent_id: parent_id)
        SELECT
            replies.*
        FROM 
            replies
        WHERE
            replies.parent_id = :parent_id

        SQL
        replies_data.map { |reply_data| Reply.new(reply_data) }
    end

end