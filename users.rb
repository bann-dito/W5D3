require_relative 'QuestionsDatabase.rb'

class User
  attr_accessor :fname, :lname

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
end
