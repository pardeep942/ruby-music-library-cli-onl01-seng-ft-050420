class Artist
  extend Concerns::Findable

  attr_accessor :name

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    obj = self.new(name)
    obj.save
    obj
  end

  def songs
    @songs
  end

  def add_song(song)
    songs << song if !songs.include?(song)
    song.artist = self if song.artist.nil?
  end

  def genres
    songs.map {|song| song.genre}.uniq
  end

end