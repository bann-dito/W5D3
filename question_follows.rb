require_relative "QuestionsDatabase.rb"
require_relative "users.rb"
require_relative "questions.rb"

class QuestionFollow


    def self.followers_for_question_id(question_id)
        users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
            users.id, fname, lname
        FROM
            question_follows, users
        WHERE
            question_id = ? AND
            question_follows.user_id = users.id;
        SQL

        users.map { |user| User.new(user)}
    end

    def self.followed_question_for_user_id(user_id)
        questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT
            questions.id, title, body, author_id
        FROM
            question_follows, questions
        WHERE
            question_follows.user_id = ? AND
            question_follows.question_id = questions.id;
        SQL

        questions.map { |question| Questions.new(question)}
    end


end