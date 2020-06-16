class MusicLibraryController
  attr_accessor :path

  def initialize(path = './db/mp3s')
    MusicImporter.new(path).import
  end

  def call
    user_input = nil
    until user_input == "exit"
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
  end

  def list_songs
    Song.all.sort_by!{|s|s.name}.each.with_index(1) do |song, index|
      puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    Artist.all.sort_by!{|a|a.name}.each.with_index(1) do |artist, index|
      puts "#{index}. #{artist.name}"
    end
  end

  def list_genres
    Genre.all.sort_by!{|g|g.name}.each.with_index(1) do |genre, index|
      puts "#{index}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
      input = gets.strip
      counter = 0
    if Artist.find_by_name(input)
      Song.all.sort_by!{|s|s.name}.each do |song|
        if song.artist.name == input
          counter += 1
          puts "#{counter}. #{song.name} - #{song.genre.name}"
        end
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    counter = 0
    if Genre.find_by_name(input)
      Song.all.sort_by!{|s|s.name}.each do |song|
        if song.genre.name == input
          counter += 1
          puts "#{counter}. #{song.artist.name} - #{song.name}"
        end
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i
    input -= 1
      if input < Song.all.length && input > 0
        song = Song.all.sort_by!{|s|s.name}
        puts "Playing #{song[input].name} by #{song[input].artist.name}"
      else
      end
    end

end