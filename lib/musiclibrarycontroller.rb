require 'pry'

class MusicLibraryController
  def initialize(path = "./db/mp3s")
    @path = path
    @importer = MusicImporter.new(path)
    @importer.import
  end

  def call
    puts("Welcome to your music library!")
    puts("To list all of your songs, enter 'list songs'.")
    puts("To list all of the artists in your library, enter 'list artists'.")
    puts("To list all of the genres in your library, enter 'list genres'.")
    puts("To list all of the songs by a particular artist, enter 'list artist'.")
    puts("To list all of the songs of a particular genre, enter 'list genre'.")
    puts("To play a song, enter 'play song'.")
    puts("To quit, type 'exit'.")
    puts("What would you like to do?")
    input = ""
    while input != "exit"
      input = gets.chomp
      case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      else
      end
    end
  end

  def sort_alphabetically(a)
    a.sort {|a, b| a.name <=> b.name}
  end

  def list_all(a)
    sort_alphabetically(a).each_with_index do |obj, index|
      puts "#{index + 1}. #{yield(obj)}"
    end
  end

  def prompt_user(message)
    puts message
    gets.chomp
  end

  def list_songs
    list_all(Song.all) do |song|
      "#{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    list_all(Artist.all) do |artist|
      "#{artist.name}"
    end
  end

  def list_genres
    list_all(Genre.all) do |genre|
      "#{genre.name}"
    end
  end

  def list_songs_by_artist
    artist = Artist.find_by_name(prompt_user("Please enter the name of an artist:"))
    if artist
      list_all(artist.songs) do |song|
        "#{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    genre = Genre.find_by_name(prompt_user("Please enter the name of a genre:"))
    if genre
      list_all(genre.songs) do |song|
        "#{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    song_list = sort_alphabetically(Song.all)
    song_number = prompt_user("Which song number would you like to play?").to_i
    song = song_number > 0 ? song = song_list[song_number - 1] : nil

    if song
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end

end
