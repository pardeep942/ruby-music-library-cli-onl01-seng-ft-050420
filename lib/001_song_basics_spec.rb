class Song
  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist
    self.genre = genre
    self.save
  end

  def self.create(name)
    new(name)
  end

  def save
    self.class.all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def artist=(artist)
    if artist != nil
      @artist = artist
      artist.add_song(self) unless artist.songs.detect { |s| s.name == self.name }
    end
  end

  def genre=(genre)
    if genre != nil
      @genre = genre
      genre.add_song(self) unless genre.songs.detect { |s| s.name == self.name }
    end
  end

  def self.find_by_name(name)
    self.all.detect { |s| s.name == name }
  end

  def self.find_or_create_by_name(name)
    song = self.find_by_name(name)
    song = self.create(name) if song == nil
    song
  end

  def self.new_from_filename(filename)
    filename.slice!(".mp3")
    data = filename.split(" - ")
    artist = Artist.find_or_create_by_name(data[0])
    name = data[1]
    genre = Genre.find_or_create_by_name(data[2])
    self.new(name, artist, genre)
  end

  def self.create_from_filename(filename)
    self.new_from_filename(filename)
  end
end
