########################################################################
# File::    install.rb
# (C)::     Hipposoft 2010
#
# Purpose:: Update the plugin.
# ----------------------------------------------------------------------
#           29-Jan-2010 (ADH): AFAICT Rails plugins have install and
#                              uninstall hooks but no upgrade hook. This
#                              file plugs the gap, though users must run
#                              it by hand. All it does right now is
#                              overwrite the support JavaScript code.
########################################################################

# Copy the configuration YAML file template into place.

require 'find'
require 'fileutils'

# Copy presumably updated local JS data into 'public'.

src_root = File.dirname( __FILE__ ) + '/lib/yui_tree/resources/'
dst_root = File.dirname( __FILE__ ) + '/../../../public/'
js_dir   = dst_root + 'javascripts/yui_tree'

def careful_mkdir( path )
  if File.exist?( path )
    raise "A file already exists at '#{ File.expand_path( path ) }'" unless File.directory?( path )
  else
    FileUtils.mkdir( path )
  end
end

puts
careful_mkdir( js_dir )

def force_copy_all( src_root, src_add, dst_dir, extension )
  src_dir = src_root + src_add

  Find.find( src_dir ) do | src_path |
    next unless ( File.extname( src_path ) == extension )
    dst_path = dst_dir + '/' + File.basename( src_path )

    puts "Copying #{ File.basename( src_path ) }..."
    FileUtils.cp( src_path, dst_path )
  end
end

force_copy_all( src_root, 'javascripts', js_dir, '.js'  )

# All done; summarise the results.

puts "Update successful."
puts
puts "For further information, check out the README file and/or generate HTML"
puts "documentation with 'rake doc:plugins:yui_tree'."
puts
