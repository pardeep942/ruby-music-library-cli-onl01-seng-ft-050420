require 'pry'

class Artist 
  extend Concerns::Findable 
  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name 
    @songs = []
  end 

  def self.all 
    @@all 
  end 

  def save 
    self.class.all << self 
  end 

  def self.create(name)
    artist = Artist.new(name)
    artist.save 
    artist 
  end 

  def self.destroy_all 
    self.all.clear 
  end 

  def add_song(song)
    if song.artist.nil?
      song.artist = self 
    else 
      nil 
    end 

    if @songs.include?(song) 
      nil 
    else 
      @songs << song 
    end 
  end 

  def genres 
    # binding.pry 
    genre_array = []
    @songs.map do |song| 
      if genre_array.include?(song.genre)
        nil 
      else 
       genre_array << song.genre  
     end 
   end 
   genre_array
  end 

end  