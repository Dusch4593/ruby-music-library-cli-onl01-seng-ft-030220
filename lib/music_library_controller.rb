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
    # sort Song objects by their names
    song_list = Song.all.sort do |song_a, song_b|
      song_a.name <=> song_b.name 
    end
    
    song_list.each.with_index(1) do |song, index|
      puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end
  
  def list_artists 
    # sort Artist objects by their names
    artist_list = Artist.all.sort do |artist_a, artist_b|
      artist_a.name <=> artist_b.name
    end
    
    artist_list.each.with_index(1) do |artist, index|
      puts "#{index}. #{artist.name}"
    end
  end
  
  def list_genres 
    # sort Genre objects by their names 
    genre_list = Genre.all.sort do |genre_a, genre_b|
      genre_a.name <=> genre_b.name
    end
    
    genre_list.each.with_index(1) do |genre, index|
      puts "#{index}. #{genre.name}"
    end
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    
    input = gets.strip
    
    if(artist = Artist.find_by_name(input))
      artist = artist.songs.sort do |song_a, song_b|
        song_a.name <=> song_b.name 
      end
      
      artist.each.with_index(1) do |song, index|
       puts "#{index}. #{song.name} - #{song.genre.name}"
      end     
    end
    
  end
end