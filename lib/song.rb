require 'nokogiri'
require 'fileutils'

class Song

  @@file
  @@folder
  @@rootdir = ENV['HOME']

  def initialize(filepath, folderpath)
    # Checks if the song file exists.
    # If it does, copies the mp3 to desktop.
    # Otherwise, prints the filepath, allowing the
    # developer to create a special naming instance.

    @@file = filepath
    @@folder = folderpath
    if file_usable?
      copy
    else
      puts "Error copying song"
      puts @@file
    end
  end

  def file_usable?
    # Determines if the song exists

    absolute_path = File.join(@@rootdir, @@file)
    return false unless File.exists?(absolute_path)
    return true
  end


  def copy
    # Uses the #FileUtils Module to copy the
    # mp3 to the folder on the Desktop.
    
    FileUtils.cd(@@rootdir)

    FileUtils.cp(@@file, @@folder)
  end

end