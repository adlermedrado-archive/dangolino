# encoding: utf-8
  
require "rubygems"
require "sequel"
require "date"
require 'optiflag'
require 'yaml'
require 'base64'
require 'rss'

config_path = File.expand_path(File.dirname(__FILE__))
config_path = config_path.gsub('/bin', '/lib')

require config_path + "/dangolino/config/dangolino_config.rb"
conf = Dangolino_Config.new

require conf.lib_dir + "/dangolino/view/post.rb"
require conf.lib_dir + "/dangolino/posting.rb"
require conf.lib_dir + "/dangolino/view/index.rb"
require conf.lib_dir + "/dangolino/load_posts.rb"
require conf.lib_dir + "/dangolino/view/all_posts.rb"
require conf.lib_dir + "/dangolino/generate_index.rb"
require conf.lib_dir + "/dangolino/generate_all_posts.rb"
require conf.lib_dir + "/dangolino/generate_rss.rb"
require conf.lib_dir + "/dangolino/markdown/markdown_parser.rb"

module CLI extend OptiFlagSet
  flag "year"
  flag "month"
  flag "file"
  flag "link"
  flag "title"
  optional_flag "format"  
  usage_flag "help"
  and_process!
end 
puts "creating file post..."

if ARGV.flags.format?
  if ARGV.flags.format == "markdown"
    input_format = ARGV.flags.format
  else
    input_format = "html"
  end
else
  input_format = "html"
end

process = Posting.new(ARGV.flags.year, ARGV.flags.month, ARGV.flags.file, ARGV.flags.link, ARGV.flags.title, input_format)
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
