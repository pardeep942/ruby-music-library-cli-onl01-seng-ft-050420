class Artist
  attr_accessor :name
  extend Concerns::Findable

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.create(name)
    new_artist = self.new(name)
    new_artist.save
    new_artist
  end

  def add_song(song)
    song.artist = self if song.artist == nil
    self.songs << song unless self.songs.include?(song)
  end

  def save
    @@all << self
  end

  def genres
    self.songs.collect {|song| song.genre}.uniq
  end

  def songs
    @songs
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

end
 14  lib/concerns/findable.rb 
@@ -0,0 +1,14 @@
module Concerns::Findable

  def find_by_name(name)
    self.all.detect {|song| song.name == name}
  end

  def find_or_create_by_name(name)
    if find_by_name(name).nil?
      self.create(name)
    else
      find_by_name(name)
    end
  end
end