require_relative 'questions_database'
require_relative 'question'
require_relative 'question_follow'
require_relative 'question_like'

class Question
    def self.find_by_id(id)
        question_data = QuestionsDatabase.get_first_row(<<-SQL, id: id)
        SELECT
            questions.*
        FROM
            questions
        WHERE
            questions.id = :id
            
        SQL
        Question.new(question_data)
    end

    def self.find_by_author_id(author_id)
        question_data = QuestionsDatabase.get_first_row(<<-SQL, author_id: author_id)
        SELECT
            questions.*
        FROM
            questions
        WHERE
            questions.author_id = :author_id
            
        SQL
        question_data.map { |question_datum| Question.new(question_datum) }
    end

    def initialize(options = {})
        @id, @title, @body, @author_id = options.values_at('id', 'title', 'body', 'author_id')
    end

end
