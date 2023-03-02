require_relative 'QuestionsDatabase.rb'
require_relative 'users.rb'
require_relative 'questions.rb'

class Reply

    def self.find_by_question_id(question_id)
        reply = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
            *

        FROM
            replies

        WHERE
            question_id = ?;
        SQL
        reply.map {|replies| Reply.new(replies)}
    end

    def self.find_by_user_id
        
    end

    def initialize (options = {})

        @id = options['id']
        @question_id = options['question_id']
        @author_id = options['author_id']
        @body = options['body']
        @parent_reply_id = options['parent_reply_id']
        
    end
end