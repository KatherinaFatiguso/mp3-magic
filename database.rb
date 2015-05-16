#  Requirements
#
#  Your Jukebox should be able to:
#  - Provide a list of songs
#  - Search for a song by title (hint: you can use =~ in PostgreSQL)
#  - Add a song to a playlist
#  - Start playing your playlist

require 'rubygems'
require 'pg'
require './player'

class Database
  def self.connection(dbopts = {})
    @@conn ||= PG.connect(dbopts)
  end
end
