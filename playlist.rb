require 'rubygems'
require 'pg'
require './player'
require './database'

class Playlist < Database

  TABLE_NAME = "playlist"
  TABLE_NAME1 = "songs"

  def add(song_id)
    self.class.connection.exec(
    "INSERT INTO #{TABLE_NAME} (playlist_id)
    VALUES (#{song_id})"
    )
  end

  def read
    result = self.class.connection.exec(
      "SELECT #{TABLE_NAME1}.id, #{TABLE_NAME1}.title
      FROM #{TABLE_NAME} INNER JOIN #{TABLE_NAME1}
      ON #{TABLE_NAME}.playlist_id = #{TABLE_NAME1}.id
      GROUP BY #{TABLE_NAME1}.id;")
      #Basically, this is how the SQL sentence looks like:
      #SELECT songs.id, songs.title FROM playlist INNER JOIN songs ON playlist.playlist_id = songs.id GROUP BY songs.id;

      result.each do |value|
        puts "#{value['id']} - #{value['title']}"
      end
  end

  def delete(id)
    self.class.connection.exec("DELETE FROM playlist WHERE playlist.playlist_id = #{id};")
  end

  def is_empty
    result = self.class.connection.exec("SELECT COUNT(*) FROM #{TABLE_NAME};")
    return (result[0]['count'] == '0') #returns true if result is "0"
  end

  def play_the_playlist
    result = self.class.connection.exec(
      "SELECT #{TABLE_NAME1}.title
      FROM #{TABLE_NAME} INNER JOIN #{TABLE_NAME1}
      ON #{TABLE_NAME}.playlist_id = #{TABLE_NAME1}.id
      GROUP BY #{TABLE_NAME1}.id;")
      if result.ntuples != 0
        Player.play("#{result[0]['title']}")
      else
        return false
      end
  end

  def stop_the_playlist
      Player.stop
  end

end

Database.connection(dbname: 'jukebox')

=begin
#for testing
playlist1 = Playlist.new
# playlist1.add(1)
# playlist1.add(2)
result = playlist1.read
result.each do |value|
  puts "#{value['id']} - #{value['title']}"
end

if (playlist1.is_empty?)
  puts "empty"
else
  puts "not empty"
end

playlist1.play_the_playlist
=end
