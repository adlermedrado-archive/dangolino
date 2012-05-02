class GenerateRss
  def initialize
    config = Dangolino_Config.new
    @generate_dir = config.generate_dir
    @url = config.url
  end

  def do_it
    load_posts = LoadPosts.new
    posts = load_posts.load
    
    rss = RSS::Maker.make("atom") do |maker|
      maker.channel.author = "adler"
      maker.channel.updated = Time.now.to_s
      maker.channel.about = "#{@url}/feed"
      maker.channel.title = "Blog do Adler"

      (0..2).each do |i|
        maker.items.new_item do |item|
          item.link = "#{posts[i]['link']}"
          item.title = posts[i]['title']
          item.updated = posts[i]['date']
        end
      end
    end

    # puts rss

    File.open(@generate_dir + "/feed/index.html", "w:utf-8") do |f|
      f.puts rss
    end
  end

end
