class Genre
  extend Concerns::Findable
  attr_accessor :name, :songs
  @@all = []

