# encoding: utf-8

config_path = File.expand_path(File.dirname(__FILE__))
config_path = config_path.gsub('/bin', '/lib')
  
require "rubygems"
require "sequel"
require "date"
require 'optiflag'
require 'yaml'
require 'base64'
require 'rss'
require config_path + "/dangolino/modules/cli.rb"
require config_path + "/dangolino/config/dangolino_config.rb"

conf = Dangolino_Config.new($settings_file)

require conf.lib_dir + "/dangolino/view/post.rb"
require conf.lib_dir + "/dangolino/posting.rb"
require conf.lib_dir + "/dangolino/view/index.rb"
require conf.lib_dir + "/dangolino/load_posts.rb"
require conf.lib_dir + "/dangolino/view/all_posts.rb"
require conf.lib_dir + "/dangolino/generate_index.rb"
require conf.lib_dir + "/dangolino/generate_all_posts.rb"
require conf.lib_dir + "/dangolino/generate_rss.rb"
require conf.lib_dir + "/dangolino/markdown/markdown_parser.rb"
 
puts "creating file post..."

process = Posting.new(ARGV.flags.year, ARGV.flags.month, ARGV.flags.file, ARGV.flags.link, ARGV.flags.title, $input_format, $settings_file)
process.post_it
puts "done..."

puts "Generating new index file..."
new_index = GenerateIndex.new($settings_file)
new_index.do_it
puts "done..."

puts "Generating new all posts file..."
new_all_posts = GenerateAllPosts.new($settings_file)
new_all_posts.do_it
puts "done..."


puts "Generating RSS file..."
new_rss = GenerateRss.new($settings_file)
new_rss.do_it
puts "done..."
