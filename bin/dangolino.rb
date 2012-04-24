# encoding: utf-8
  
require "rubygems"
require "sequel"
require "date"
require "../lib/dangolino/import/post.rb"
require "../lib/dangolino/posting.rb"
require 'optiflag'

module CLI extend OptiFlagSet
  flag "year"
  flag "month"
  flag "file"
  flag "link"
  flag "title"  
  usage_flag "help"
  and_process!
end 

process = Posting.new(ARGV.flags.year, ARGV.flags.month, ARGV.flags.file, ARGV.flags.link, ARGV.flags.title)
process.post_it

# puts "User has input:#{ ARGV.flags.year  } for dir"
# puts "User has input:#{ ARGV.flags.month  } for log"
# puts "User has input:#{ ARGV.flags.file  } for username"
# puts "User has input:#{ ARGV.flags.link  } for password"

# wordpress = Wordpress.new
# wordpress.import