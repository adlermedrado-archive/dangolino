# encoding: utf-8
  
require "rubygems"
require "sequel"
require "date"
require 'optiflag'
require 'yaml'
require 'base64'
require 'rss'

require "../lib/dangolino/config/dangolino_config.rb"
conf = Dangolino_Config.new

require conf.lib_dir + "/dangolino/view/post.rb"
require conf.lib_dir + "/dangolino/posting.rb"
require conf.lib_dir + "/dangolino/view/index.rb"
require conf.lib_dir + "/dangolino/load_posts.rb"
require conf.lib_dir + "/dangolino/view/all_posts.rb"
require conf.lib_dir + "/dangolino/generate_index.rb"
require conf.lib_dir + "/dangolino/generate_all_posts.rb"
require conf.lib_dir + "/dangolino/generate_rss.rb"
module CLI extend OptiFlagSet
  flag "year"
  flag "month"
  flag "file"
  flag "link"
  flag "title"  
  usage_flag "help"
  and_process!
end 
puts "creating file post..."
process = Posting.new(ARGV.flags.year, ARGV.flags.month, ARGV.flags.file, ARGV.flags.link, ARGV.flags.title)
process.post_it
puts "done..."

puts "Generating new index file..."
new_index = GenerateIndex.new
new_index.do_it
puts "done..."

puts "Generating new all posts file..."
new_all_posts = GenerateAllPosts.new
new_all_posts.do_it
puts "done..."


puts "Generating RSS file..."
new_rss = GenerateRss.new
new_rss.do_it
puts "done..."
