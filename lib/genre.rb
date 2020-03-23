class Genre
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
    genre = self.new(name)
    genre
  end
  
  def songs 
    @songs 
  end
  
  def artists 
    songs.collect do |song|
      song.artist
    end.uniq
  end
  
end 