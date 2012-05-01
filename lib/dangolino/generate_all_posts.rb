class GenerateAllPosts
  def initialize
    config = Dangolino_Config.new
    @generate_dir = config.generate_dir
  end

  def do_it
    load_posts = LoadPosts.new
    posts = load_posts.load
    all_posts = AllPosts.new(posts)
    File.open(@generate_dir + "/all-posts.html", "w:utf-8") do |f|
      f.puts all_posts.render
    end
  end
end