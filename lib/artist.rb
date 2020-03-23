require 'pry'

class Artist 
  extend Concerns::Findable
  @@all = []
  attr_accessor :name 
  
  def initialize(name)
    @name = name 
    @songs = []
    save
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
    self.new(name)
  end
  
  def songs 
    @songs 
  end
  
  def add_song(song)
    song.artist = self unless song.artist 
    songs << song unless songs.include?(song)
  end
  
  def genres
    songs.collect do |song|
      song.genre
    end.uniq
  end
end