require_relative 'questions_database'
require_relative 'user'
require_relative 'question'
require_relative 'model_base'

class QuestionLike < ModelBase
  def self.likers_for_question_id(question_id)
    users_data = QuestionsDatabase.execute(<<-SQL, question_id: question_id)
      SELECT
        users.*
      FROM
        users
      JOIN
        question_likes
      ON
        users.id = question_likes.user_id
      WHERE
        question_likes.question_id = :question_id
    SQL

    users_data.map { |user_data| User.new(user_data) }
  end
