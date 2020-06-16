class Song
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if !artist.nil?
    self.genre = genre if !genre.nil?
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self if !@@all.include?(self)
  end

  def self.create(name)
    obj = self.new(name)
    obj.save
    obj
  end

  def artist=(artist)
    @artist = artist
    @artist.add_song(self) if !artist.songs.include?(self)
  end

  def genre=(genre)
    @genre = genre
    @genre.songs << self if !@genre.songs.include?(self)
  end

  def self.new_from_filename(filename)
    artist_s, name_s, genre_s = filename.gsub(".mp3", "").split(" - ")
    song = find_or_create_by_name(name_s.strip)
    song.artist = Artist.find_or_create_by_name(artist_s.strip)
    song.genre = Genre.find_or_create_by_name(genre_s.strip)
    song
  end

  def self.create_from_filename(filename)
    new_from_filename(filename).save
  end

end