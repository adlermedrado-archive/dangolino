require "../lib/dangolino/import/post.rb"
require "../lib/dangolino/import/wordpress"

puts "Importing wordpress - Begin"
wordpress = Wordpress.new
wordpress.import
puts "Importing wordpress - End"