class MusicImporter
  attr_reader :path

  def initialize(path)
    self.path = path
  end

  def path=(path)
    @path = path
  end

  def files
    Dir.glob("#{self.path}/*.mp3").each do |filename|
      filename.slice!("#{self.path}/")
    end
  end

  def import
    self.files.each do |filename|
      Song.create_from_filename(filename)
    end
  end
end