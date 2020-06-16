class Artist
  extend Concerns::Findable 
  attr_accessor :name, :song, :genre



    @@all = [ ]

    #creates a 'songs' property set to an empty array (artist has many songs)
    def initialize(name)
      @name = name
      @songs = [ ]
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


    def self.create(name)
      a = self.new(name).save
      @@all.last

    end

    def add_song(song)
       self.have_an_artist(song)

       if !(@songs.include? (song))
          @songs << song
       elsif
         nil
       end
    end

    def have_an_artist(song) 
        if song.artist == nil
            song.artist = self
        elsif
            nil
        end
    end

    #returns the artist's 'songs' collection (artist has many songs)
    def songs
        @songs
    end

    # returns a collection of genres for all of the artist's songs (artist has many genres through songs)
    #does not return duplicate genres if the artist has more than one song of a particular genre by using 
    #the .uniq method
    #(artist has many genres through songs)
    #collects genres through its songs instead of maintaining its own @genres instance variable 
    #(artist has many genres through songs)
    def genres
      song_genres = self.songs.collect {|song| song.genre}
        song_genres.uniq
    end


  end  
