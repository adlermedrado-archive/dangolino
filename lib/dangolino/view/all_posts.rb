# encoding: utf-8

require "mustache"

class AllPosts < Mustache

  def initialize(data, config)
    @data = data
    self.template_path = config.template_dir
  end
  def posts
    @data
  end
end