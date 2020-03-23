require 'pry'

class Song 
  attr_accessor :name, :artist, :genre
  
  @@all = []
  
  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end
  
  def self.all 
    @@all 
  end
  
  def self.destroy_all 
    self.all.clear 
  end
  
  def save 
    self.class.all << self 
  end
  
  def self.create(name)
    song = new(name)
    song.save
    song
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre 
    genre.songs << self unless genre.songs.include?(self)
  end
  
  def self.find_by_name(name)
    self.all.detect do |song|
      song.name == name
    end
  end
  
  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end
  
  def self.new_from_filename(filename)
    pieces = filename.split(" - ")
    song = create(pieces[1])
    song.artist = Artist.find_or_create_by_name(pieces[0])
    song.genre = Genre.find_or_create_by_name(pieces[2].chomp(".mp3"))
    song
  end
  
  def self.create_from_filename(filename)
    song = new_from_filename(filename)
    song.save
  end
end