class MusicLibraryController
    attr_accessor :path, :song, :artist, :genre

    # accepts one argument, the path to the MP3 files to be imported
    #creates a new MusicImporter object, passing in the 'path' value
    #the 'path' argument defaults to './db/mp3s'
    #invokes the #import method on the created MusicImporter object

  def initialize(path= "./db/mp3s")
    @path = path
    MusicImporter.new(path).import
  end 

  #welcomes the user. Asks the user for input
  #loops and asks for user input until they type in "exit"
  def call
    user_input = ""
    while user_input != "exit"
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    user_input = gets.strip
    if user_input == "list songs"
      self.list_songs
    elsif user_input == "list artists"
      self.list_artists
    elsif user_input == "list genres"
      self.list_genres
    elsif user_input == "list artist"
      self.list_songs_by_artist
    elsif user_input == "list genre"
      self.list_songs_by_genre
    elsif user_input == "play song"
      self.play_song
    end

  end 


  #calls on the class method sort_songs from Song and prints all songs in the music library in a 
  #numbered list (alphabetized by song name) and it is not hard-coded
  def list_songs
    Song.sort_songs

  end


  #This is a call from the extended class method sort_songs that is listed in the findable 
  #module. It prints all artists in the music library in a numbered list (alphabetized by artist name)
  #it is not hard-coded
   def list_artists
   # Artist.all.sort_by(artist.name)
    #Artist.all.each_with_index {|a,index| puts "#{index+1}. #{a.name}"}
     Artist.sort_songs
   end 

   #This is a call from the extended class method sort_songs that is listed in the findable 
  #module. It prints all genres in the music library in a numbered list (alphabetized by genre name)
  #it is not hard-coded
  def list_genres
    Genre.sort_songs
  end 

  #Prompts user to enter an artist name. Accepts the input. Prints all songs by the particular artist
  #in a numbered list that is alphabetized by song name. If no artist name is found, it will do nothing
  def list_songs_by_artist
     puts "Please enter the name of an artist:"
     user_input = gets.strip
    if artist = Artist.find_by_name(user_input)
       sorted_array = artist.songs.sort{|a,b| a.name <=> b.name}
       sorted_array.each_with_index do |song, index| 
         puts "#{index+1}. #{song.name} - #{song.genre.name}"
       end
    end

  end



  #Prompts user to enter a genre name. Accepts the input. Prints all songs of a particular genre
  #in a numbered list that is alphabetized by song name. If no genre name is found, it will do nothing
   def list_songs_by_genre
     puts "Please enter the name of a genre:"
     user_input = gets.strip
     if genre = Genre.find_by_name(user_input)
      genre_sorted_array = genre.songs.sort{|a,b| a.name <=> b.name}
      genre_sorted_array.each_with_index do |song, index| 
        puts "#{index+1}. #{song.artist.name} - #{song.name}"
       end
     end

   end 

   #Prompts the user to play a song from the alphabetized Song list. Accepts the user input. 
   #Locates the matching song and "plays" it. Does not puts out anything if song is not found.
   #Checks to make sure that the user's input (that is converted to an integer and reduced by 1)
   #matches an index of one of the songs listed. 

   def play_song
     puts "Which song number would you like to play?"
     user_input = gets.strip
     alphabetized_songs = Song.all.uniq.sort_by{|s|s.name}
     alphabetized_songs.each_with_index do |song, index| 
       if user_input.to_i-1 == index
       puts "Playing #{song.name} by #{song.artist.name}"
       end
      end
   end

     #list_of_songs_array = self.list_songs.split(/[.-]/)
     #ist_of_songs_array 
     #if self.list_songs.include?(user_input.to_i)
     #self.list_songs[user_input.to_i]
     #puts "Playing #{song.name} by #{song.artist.name}"
     #end



 end
end  