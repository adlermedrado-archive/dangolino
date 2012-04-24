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