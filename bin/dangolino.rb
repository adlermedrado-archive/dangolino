# encoding: utf-8
  
require "rubygems"
require "sequel"
require "date"
require 'optiflag'
require 'yaml'

require "../lib/dangolino/config/dangolino_config.rb"
conf = Dangolino_Config.new

require conf.lib_dir + "/dangolino/view/post.rb"
require conf.lib_dir + "/dangolino/posting.rb"

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