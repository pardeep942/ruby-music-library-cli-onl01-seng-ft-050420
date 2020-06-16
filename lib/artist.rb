class Artist
  extend Concerns::Findable

  attr_accessor :name, :genre

  @@all=[]

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
    song = self.new(name)
    song.save
    song
  end

  def songs
    @songs
  end

  def add_song(song)
    song.artist = self if !song.artist
    @songs << song if !@songs.include?(song)
  end

  def genres
    songs.map { |song| song.genre }.uniq
  end


end
