require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.results_as_hash = true #getting data as hashes
    self.type_translation = true #getting back same type of data
  end

end
