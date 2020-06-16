class Genre
  attr_accessor :name
  extend Concerns::Findable

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.create(name)
    new_genre = self.new(name)
    new_genre.save
    new_genre
  end

  def add_song(song)
    song.genre = self if song.genre.nil?
    self.songs << song unless self.songs.include?(song)
  end

  def save
    @@all << self
  end

  def songs
    @songs
  end

  def artists
    self.songs.collect {|song| song.artist}.uniq
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

end