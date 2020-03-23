require 'pry'

class MusicLibraryController 
  def initialize(path="./db/mp3s")
    MusicImporter.new(path).import 
  end
  
  def call 
    input = "" 
    while(input != "exit")
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
    
      input = gets.strip
      
      case input 
      when "list songs"
        list_songs 
      when "list artists" 
        list_artists
      when "list genres" 
        list_genres 
      when "list artist"
        list_artist 
      when "list genre"
        list_genre 
      when "play song"
        play_song
      end
    end
  end
  
  
  def list_songs
    # sort by Song objects by their names
    sorted_list = Song.all.sort do |song_a, song_b|
      binding.pry
      song_a.name <=> song_b.name 
    end
    
    sorted_list.each.with_index(1) do |song, index|
      #binding.pry
      puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end
  
  def list_artists 
    # sort by artist 
    artist_list = @music_importer.collect do |file|
      file.split(" - ")[0]
    end
    
    artist_list = artist_list.sort.uniq
    #binding.pry
    artist_list.each_with_index do |artist, index|
      puts "#{index+1}. #{artist}"
    end
  end
end