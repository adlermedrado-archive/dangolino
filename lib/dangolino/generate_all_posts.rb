class GenerateAllPosts
  def initialize(settings_file)
    @settings_file = settings_file
    @config = Dangolino_Config.new(settings_file)
    @generate_dir = @config.generate_dir
  end

  def do_it
    load_posts = LoadPosts.new(@settings_file)
    posts = load_posts.load
    all_posts = AllPosts.new(posts,@config)
    File.open(@generate_dir + "/all-posts.html", "w:utf-8") do |f|
      f.puts all_posts.render
    end
  end
end