require_relative 'questions_database'
require_relative 'question'
require_relative 'question_follow'
require_relative 'question_like'

class QuestionFollow

    def self.followers_for_question_id(question_id)
        q_follow_data = QuestionsDatabase.get_first_row(<<-SQL, question_id: question_id)
        SELECT
            users.*
        FROM
            users
        JOIN
            question_follows
        ON
            users.id = question_follows.user_id
        WHERE
            question_follows.question_id = :question_id
        SQL
        q_follow_data.map { |qf_datum| User.new(qf_datum) }    
   end

   def self.most_followed_questions(n)
        questions_data = QuestionsDatabase.execute(<<-SQL, limit: n)
        SELECT
            questions.*
        FROM
            questions
        JOIN 
            question_follows
        ON
            questions.id = question_follows.question_id
        GROUP BY
            questions.id
        ORDER BY
            COUNT(*) DESC
        LIMIT
            :limit
        SQL

        questions_data.map { |question_datum| Question.new(question_datum) }

   end

   def self.followed_questions_for_user_id(user_id)
        questions_data = QuestionsDatabase.execute(<<-SQL, user_id: user_id)

        SELECT
            questions.*
        FROM
            questions
        JOIN
            question_follows
        ON
            questions.id = question_follows.question_id
        WHERE
            question_follows.user_id = :user_id
        SQL

        questions_data.map { |questions_datum| Question.new(questions_datum) }
   end
 

end