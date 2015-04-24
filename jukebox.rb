require './player'

#  Requirements
#
#  Your Jukebox should be able to:
#  - Provide a list of songs
#  - Search for a song by title (hint: you can use =~ in PostgreSQL)
#  - Add a song to a playlist
#  - Start playing your playlist
#
#  You can store you actual mp3 files in the music directory
#  and play them using Player.play(filename)
#
#  You can also stop the currently playing song with Player.stop
#
#  You should use a database to store your Jukebox's song library
#
#  Use object orientation and exceptions where appropriate
#
#  Optional:
#
#  Record each time a song is played and generate a report on popular songs.
#
#  Optional 2:
#
#  Record the start and end time stamps for when a song is played and Stopped
#  Include in your report what % of songs are played through
#  (Listeners will often skip songs they don't like so this is a good indicator
#  of whether they like a song or not).
#

loop do
  puts "What would you like to play?"
  filename = gets.chomp
  Player.play(filename)
  sleep 20
  Player.stop
end

