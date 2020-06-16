require 'pry'

class MusicImporter

  attr_accessor :path

  def initialize(path)
    @path = path
    @files = Dir.entries(path).select {|file| file.match(/\.mp3/)}
  end

  def files
    @files
  end

  def import
    files.each { |file| Song.create_from_filename(file)}
  end

end
