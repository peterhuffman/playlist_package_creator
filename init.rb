#### Playlist Package Creator ####

# Launch this Ruby file from the command line 
# to get started.


require 'fileutils'

APP_ROOT = File.dirname(__FILE__)

$:.unshift( File.join(APP_ROOT, 'lib') )
require 'guide'

guide = Guide.new
guide.launch!