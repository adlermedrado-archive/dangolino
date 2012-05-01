# encoding: utf-8

require "mustache"

class AllPosts < Mustache
  self.template_path = File.dirname(Dir.pwd) + "/templates"
  
  def initialize(data)
    @data = data
  end
  def posts
    @data
  end
end