require 'playlist'
require 'fileutils'
require 'song'

class Guide

  def initialize
    # Prints instructions on how to export an
    # iTunes playlist as an .xml file.

    puts "Welcome to the Playlist Package Creator\n\n"
    puts "Instructions:"
    puts "1. Open your iTunes application."
    puts "2. Select a playlist that you've created."
    puts "3. Navigate to File/Library/Export Playlist..."
    puts "4. Export the playlist as a .XML file to your desktop.\n"
  end

  def launch!
  # Main application script. Allows for repetition.

    result = introduction

    # Exits loop when user chooses not to create
    # a playlist package.
    until (result == :quit)
      playlist = Playlist.new

        if playlist.file_usable?
          playlist.create
          puts "Playlist Package created!"
        else
          puts ".xml file unusable, please try another file."
        end
            
            result = introduction
        end

        conclusion

    end

    def introduction
        # Allows the user the choice of creating a package
        # or exiting the application.
        
        input = 'no choice'

        # Loops until a valid answer is received.
        until (input == "y" || input == "n")
            puts "Would you like to create a playlist package? (Y) Yes\t(N) No"
            print ">"
            input = gets.chomp.downcase

            if (input != "y" && input != "n")
                puts "Incorrect response.  Please try again."
            end
        end

        return nil unless input == "n"
        return :quit
    end

    def conclusion
        print "\n\n *** Thank you for using the Playlist Package Creator *** \n\n"
    end
end