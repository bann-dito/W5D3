require_relative 'QuestionsDatabase.rb'
require_relative 'question_follows.rb'

class User
  attr_accessor :fname, :lname, :id

  def self.find_by_id(id)
    new_user = QuestionsDatabase.instance.execute(<<-SQL, var: id)
    SELECT
      *
    FROM
      users
    WHERE
      users.id = :var;
    SQL
    return nil if new_user.empty?
    User.new(new_user.first)
  end

  # def self.find_by_fname(fname)
  #   new_users = QuestionsDatabase.instance.execute(<<-SQL, fname)
  #   SELECT
  #     *
  #   FROM
  #     users
  #   WHERE
  #     users.fname = ?;
  #   SQL
  #   new_users.map { |new_user| User.new(new_user) }
  #   [{} {}]
  #   [ < > , < > ]
  # end

  def self.find_by_name(fname, lname)
    new_user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
    SELECT
      *
    FROM
      users
    WHERE
      users.fname = ? AND users.lname = ?;
    SQL
    return nil if new_user.empty?
    User.new(new_user.first)
  end

  def initialize(options = {})
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def followed_question_for_user_id
    QuestionFollow.followed_question_for_user_id(self.id)
  end

end
