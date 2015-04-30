require 'fileutils'
require 'nokogiri'
require 'song'
require 'uri'

class Playlist

  @@root = ENV['HOME']
  @@filepath = nil
  @@desktop = File.join(@@root, 'Desktop')
  @@xml_files
  @@filename = nil
  @@foldername
  @@folderpath = nil
  @@songs = []


  def initialize
    # Locates all playlist files on Desktop,
    # allows user to choose a playlist,
    # creates folder on the Desktop with the
    # same name as the playlist.

    # variables

    # scripts
    Playlist.get_playlist_name
    Playlist.choose_playlist
    Playlist.create_folder
  end
  
  def self.get_playlist_name
    # Displays all .xml files on Desktop,
    # populates @@xml_files array.

    # selects only those with file extension = .xml
    desktop_files = Dir.entries(@@desktop)
    @@xml_files = desktop_files.select{ |file| File.basename(file).include? ".xml"}

    # Prints a menu of .xml files to select
    puts "\n\nPlaylist Files:"
    i = 1
    @@xml_files.each do |file|
      puts "#{i}. #{file}"
      i +=1
    end
  end

  def self.choose_playlist
    # Prints the contents of @@xml_files
    # in a menu-format. Prompts user to 
    # choose a playlist.  Only accepts 
    # valid integers.

    file = nil
    while file == nil
      puts "Please choose a playlist:"
      print ">"
      user_input = gets.chomp.to_i - 1
      if ((user_input.is_a? Integer) && user_input < @@xml_files.size)
        file = @@xml_files[user_input]
      else
        puts "Invalid choice.  Please chooose again."
      end
    end

    # updates the class variables relating to
    # the user's file choice.
    @@filename = file
    @@filepath = File.join(@@desktop, file)
  end

  def self.create_folder
    # Creates a folder with the same name as the playlist
    # moves the .xml file into the folder and deletes the original
    # from the desktop.

    FileUtils.cd(@@desktop)

    # Creates folder with the same name as the playlist file
    # on the user's desktop.
    @@foldername = @@filename.split('.')[0]
    FileUtils.mkdir @@foldername, :mode => 0777

    # Copies the playlist .xml file, updates the class variables
    # for @@filepath and @@folderpath
    FileUtils.cp(@@filename, @@foldername)
    @@filepath = File.join(@@desktop, @@foldername, @@filename)
    FileUtils.remove @@filename
    @@folderpath = File.join(@@desktop, @@foldername)
  end

  def create
    # Script for parsing the playlist file,
    # copying each song into the package folder.

    Playlist.parse_xml
    Playlist.copy_songs
  end


  def file_usable?
    # Returns true unless the file is non-existent,
    # unreadable, unwritable or has not been provided.

    FileUtils.cd(@@foldername)
    FileUtils.chmod 0777, @@filename 

    return false unless @@filename
    return false unless File.exists?(@@filename)
    return false unless File.readable?(@@filename)
    return true
  end

  def self.parse_xml
    # Parses xml, returns all string objects
    # who have three dictionary parents.

    FileUtils.cd(@@root)

    file = File.open(@@filepath)
    xml_doc = Nokogiri::XML(file)
    file.close

    # Calls the create_song_filepaths method to 
    # parse through the 'strings' array and return
    # only the filepaths of each song.
    xml_root = xml_doc.root
    strings = xml_root.xpath("dict/dict/dict/string")
    Playlist.create_song_filepaths(strings)
  end

  def self.create_song_filepaths(string_array)
    # Switches xml string object "Location" to the
    # filepath of an individual song file.

    # Empties the @@songs file array.
    @@songs = []

    string_array.each do |string|
      if string.text.include? "file:"
        @@songs << string.text
      end
    end

    # Uses a temporary string array to store
    # each filepath.
    tempsongs = []

    if @@songs.any?

      @@songs.each do |song|
        song = song.split(@@root)[1]
        song = song[1..-1]
        song = URI.decode(song)
        tempsongs << song
      end
    else
      puts "Error: @@songs is empty..."
    end

    # Updates the @@songs array such that it contains the filepaths of all mp3s.
    @@songs = tempsongs
  end

  def self.copy_songs
    # Creates song object for each filepath in @@song

    @@songs.each do |song|
      song_to_copy = Song.new(song, @@folderpath)
    end
  end
  
end
