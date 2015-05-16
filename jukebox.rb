

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
require 'rubygems'
require 'pg'
require './player'
require './database'
require './song'
require './playlist'

playlist = Playlist.new
song = Song.new(2)

$menu =  "\n\n******************************\n"
$menu += "Welcome to The Awesome Jukebox\n"
$menu += "*******************************\n"
$menu += "Please choose the menu:\n"
$menu += "1. List the songs.\n"
$menu += "2. Search for a song by its title.\n"
$menu += "3. Display songs in my playlist.\n"
$menu += "4. Delete a song in my playlist.\n"
$menu += "5. Play songs in my playlist.\n"
$menu += "6. Quit.\n"


def query
  puts $menu
  puts "\nWhat would you like to do?\n"
  response = gets.chomp.to_i
  if response == 6
    nil
  else
    response
  end
end

while response = query
  case response
    when 1 #list the songs from database
      puts "\nList of songs:\n"
      puts Song.all
      puts "\nEnter the song ID to play:\n"
      id = gets.chomp
      if song.id_not_found(id)
        puts "**Please enter the correct song ID.\n"
      else
        Song.new(id).play
        puts "\nTo stop, press 's' and enter\n"
        resp = gets.chomp
        if (resp == 's' || resp == 'S')
          Player.stop
        end
      end

    when 2 #search for a song by its title
      puts "\nEnter the song title to search:\n"
      title = gets.chomp
      if song.title_not_found(title)
        puts "**Song title does not exist.\n"
      else
        id = song.find_id_by_title(title) #finds the id of the song
        song.id = id
        puts song
        puts "Add this song into my playlist? y / n\n"
        resp = gets.chomp
        if (resp == 'y' || resp == 'Y')
          playlist.add(id)
        end
      end

    when 3 #display songs in my playlist
      if playlist.is_empty
        puts "**Empty playlist\n"
      else
        puts "\nThis is the list of songs in my playlist:\n"
        playlist.read
      end

    when 4 #delete a song in playlist
      if playlist.is_empty
        puts "**Empty playlist\n"
      else
        puts "\nThis is the current list of songs in my playlist:\n"
        playlist.read
        puts "\nEnter the song ID to delete:\n"
        id = gets.chomp
        if song.id_not_found(id)
          puts "**Please enter the correct song ID.\n"
        else
          playlist.delete(id)
          puts "**Deleted.\n"
        end
      end


    when 5 #play songs in my playlist
      if playlist.is_empty
        puts "**Empty playlist\n"
      else
        playlist.play_the_playlist
        puts "\nTo stop, press 's' and enter\n"
        resp = gets.chomp
        if (resp == 's' || resp == 'S')
           playlist.stop_the_playlist
        end
      end
  else
    puts "Incorrect input, please select numbers from the menu."
  end
end

puts "Thank you for using the Awesome Jukebox."
