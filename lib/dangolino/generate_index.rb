class GenerateIndex

  def initialize
    config = Dangolino_Config.new
    @generate_dir = config.generate_dir
  end

  def do_it
    load_posts = LoadPosts.new
    posts = load_posts.load
    index = Index.new(posts)
    File.open(@generate_dir + "/index.html", "w:utf-8") do |f|
      f.puts index.render
    end
  end
end