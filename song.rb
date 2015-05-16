require 'rubygems'
require 'pg'
require './player'
require './database'

class Song < Database
  TABLE_NAME = "songs"
  attr_accessor :id

  def initialize(id)
    @id = id
  end

  def self.all
    result = self.connection.exec("SELECT id FROM songs;")
    result.map do |row|
      new(row['id'])
    end
  end

  def read
    self.class.connection.exec("SELECT * FROM songs where id=$1;", [@id])[0]
  end

  def title_not_found(title)
    result = self.class.connection.exec("SELECT * FROM songs where title~*$1;", [title])
    result.ntuples == 0
  end

  def id_not_found(id)
    result = self.class.connection.exec("SELECT * FROM songs where title~*$1;", [id])
    result.ntuples == 0
  end

  def find_id_by_title(title)
    result = self.class.connection.exec("SELECT * FROM songs where title~*$1;", [title])[0]
    (result['id']).to_i
  end

  def to_s
    hash = read
    "#{hash['id']}: #{hash['title']}"
  end

  def play
    Player.play(read['title'])
  end
end # end of class Song

Database.connection(dbname: 'jukebox')


=begin
#for testing
puts Song.all
puts "hello\n"
test = Song.new(2)

puts test.find_id_by_title('space')

if test.title_not_found('blah')
  puts "title not found"
else
  puts "title found"
end
if test.id_not_found('durian')
  puts "id not found"
else
  puts "id found"
end
 # puts test

=end
