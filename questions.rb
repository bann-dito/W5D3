require_relative 'QuestionsDatabase.rb'
require_relative 'question_follows.rb'
require_relative 'replies.rb'

class Questions

    attr_reader :id

    def self.find_by_id(id)
        new_question = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            questions
        WHERE
            id = ?
        SQL
        Question.new(new_question.first)
    end


    def self.find_by_author_id(author_id)
        new_question = QuestionsDatabase.instance.execute(<<-SQL, author_id)
        SELECT
            *
        FROM
            questions
        WHERE
            author_id = ?
        SQL
        Question.new(new_question.first)
    end

    def initialize(options = {})
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end

    def followers
        QuestionFollow.followers_for_question_id(self.id)
    end

    def author
        @author_id
    end

    def replies
        Reply.find_by_question_id(self.id)
    end



  

end
