class Song
  attr_accessor :name, :artist, :genre


  @@all = [ ]

  #song objects can be initialized with an optional artist argument. The song will only be assigned an 
  #artist if the artist property is not equal to nil
  def initialize(name, artist=nil, genre=nil )
    @name = name
    self.artist= artist if artist!=nil
    self.genre= genre if genre!=nil
  end 

  def self.all
    @@all
  end 

  def save
    @@all << self
  end 

  def self.destroy_all
    @@all = [ ]
  end 

  #The .create method  initializes, saves, and returns the song
  def self.create(name)
    s = self.new(name).save
    @@all.last

  end

  #invokes Artist#add_song to add itself to the artist's collection of songs (artist has many songs)
  def artist=(artist)
    @artist = artist
    artist.add_song(self)

  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  #finds a song instance in @@all by the name property of the song
  def self.find_by_name(name)
    @@all.detect{|s| s.name == name}
  end 

  #returns (does not recreate) an existing song with the provided name if one exists in @@all
  #invokes .find_by_name instead of re-coding the same functionality
  #creates a song if an existing match is not found
  #invokes .create instead of re-coding the same functionality
  #The code basically says execute the find_by_name method. If that method gives a truthy value, then
  #return the song instance. If that method returns a falsy value, then execute the self.create method.
  #Essentially find the song or create it! 
  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)

  end

  #This class method .new_from_filename  initializes a song based on the passed-in filename
    #that's passed into it and invokes the appropriate Findable methods so as to avoid 
    #duplicating objects
  def self.new_from_filename(filename)
      #This turns the file name from "Thundercat - For Love I Come - dance.mp3" into this
      #[Thundercat, For Love I Come, dance] which is [artist, name, genre]. It removed the .mp3
      #and split the string into an array based on the "-"
    separated_file = filename.gsub(".mp3", "").split(" - ") 

      #Now we can access the elements from the array by using their indexes and then initialize the
      #song by placing the variables in the right place when calling .new
    artist = Artist.find_or_create_by_name(separated_file[0])
    genre = Genre.find_or_create_by_name(separated_file[2])
    self.new(separated_file[1], artist, genre)

  end

    #initializes and saves a song based on the passed-in filename
    #invokes .new_from_filename instead of re-coding the same functionality

    def self.create_from_filename(filename)
        self.new_from_filename(filename).save
    end 

    #This class method sorts the list of songs alphabetically by Song name, formats the songs like this:
    # 1. Thundercat - For Love I Come - dance which is 1. artist name - song name - genre name. We later 
    #call this method within one of the music library controller CLI methods, "list_songs"
    def self.sort_songs
      counter = 1
      sorted_array = self.all.uniq.sort_by{|s|s.name}
      sorted_array.map do |e|
        puts "#{counter}. #{e.artist.name} - #{e.name} - #{e.genre.name}"
        counter += 1
       end
    end


end  