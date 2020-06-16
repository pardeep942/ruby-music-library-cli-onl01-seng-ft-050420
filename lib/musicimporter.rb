class MusicImporter
    #the attr_accessor path retrieves the path provided to the MusicImporter object
    attr_accessor :path

  #This initialize method accepts a file path to parse mp3 files from
  def initialize(path)
    @path = path
  end

  #Here the file method accesses the path where the mp3 files are located, lists them, 
  #and uses the .gsub method to replace the path name with an empty string "" so
  #that we only have the mp3 filename with no path listed (normalizes the filename to just the MP3 
  #filename with no path)
  def files
    @files ||= Dir.glob("#{path}/*.mp3").collect{ |f| f.gsub("#{path}/", "") }

  end

  #The import method imports the files into the library by creating songs from a filename
  def import
    files.each {|file| Song.create_from_filename(file)}
  end 

end  