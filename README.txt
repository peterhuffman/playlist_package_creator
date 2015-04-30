Playlist Package Creator

VERSION 0.0.1

~~~~~~~~~~~~~~~~~~~~~~~~~Created by Peter Huffman~~~~~~~~~~~~~~~~~~~~~~~~~~



\\\\\\\\\\\\\\\\\\\\\\\\\Instructions//////////////////////////////////////

*** Exporting a .xml file from iTunes ***
1. Open iTunes.
2. Navigate to a playlist that contains at least one music file.
3. In the Menu bar, go to File --> Library --> Export Playlist..
4. Name the output file, and MAKE SURE TO SAVE IT TO YOUR DESKTOP.
Note: The filename should be unique, there should not be any directory on your Desktop that shares its name.

*** Launching the application ***
1. Use the command line to run the 'init.rb' script.
   --> ruby init.rb
2. Follow the printed instructions.  At anytime you may use 'CTRL-C' to force quit.

\\\\\\\\\\\\\\\\\\\\\\\\\Application Structure/////////////////////////////

~ init.rb ~

- Acts as a script to initialize the guide object.  
- Defines the root filepath and where to look for class files.

~ playlist.rb ~

*Function:

Playlist object represents a single iTunes .xml playlist file.  

*Methods:

- initialize: locates all playlist files on Desktop, allows user to choose a playlist, creates a folder on the desktop with the same name as the playlist.

- get_playlist_name: displays all .xml files on Desktop, populates @@xml_files array.

- choose_playlist: prints the contents of @@xml_files in a menu-format.  Prompts user to choose a playlist.  Only accepts valid integers.

- create_folder: creates a folder with the same name as the playlist.  Moves the .xml file into the folder and deletes the original from the desktop.

- create: script for parsing the playlist file, copying each song into the package folder.

- file_usable?: returns true unless the file is non-existant, unreadable, unwritable or has not been provided.

- parse_xml: parses the .xml file, returns all string objectss who have three dictionary parents.

- create_song_filepath: switches the .xml string object "Location" to the filepath of an individual song title.

-copy_songs: creates song object for each filepath in @@song.

~ guide.rb ~

*Function:

- Prints instructions, outlines application script.

*Methods:

- initialize: prints playlist export instructions
        
- launch!: runs the script to create an individual playlist package
        
- introduction: allows the user the choice of creating a package or exiting the application.

- conclusion: prints exit message

~ song.rb ~

*Function:

Song object represents a single audio file.
        
*Methods:

- initialize: checks if the song file exists.  If it does, copies the mp3 to desktop.  Otherwise, prints the filepath, allowing the developer to create a special naming instance.

- copy: uses the FileUtils module to copy the audio file to the folder on the Desktop.

\\\\\\\\\\\\\\\\\\\\\\\\\Known Bugs || Solved Bugs/////////////////////////

- For some reason, when initializing a new Playlist object, the object variables are not getting re-initialized to their default values.  This means that within the method "create_song_filepaths" the variable @@songs still contains the filepaths of the previous playlist created.  This bug was solved by setting @@songs equal to an empty array previous to adding each playlist's filepaths.