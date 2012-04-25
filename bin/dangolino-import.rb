require "rubygems"
require 'yaml'
require "sequel"
require "../lib/dangolino/config/dangolino_config.rb"

conf = Dangolino_Config.new

require conf.lib_dir + "/dangolino/import/post.rb"
require conf.lib_dir + "/dangolino/import/wordpress.rb"

puts "Importing wordpress - Begin"
wordpress = Wordpress.new
wordpress.import
puts "Importing wordpress - End"