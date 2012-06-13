class LoadPosts

  def initialize(settings_file)
    config = Dangolino_Config.new(settings_file)
    @data_file = config.datafile
    @generate_dir = "#{config.generate_dir}/feed/index.html"
    @url = config.url
  end

  def load
    @posts = Array.new
    File.open(@data_file).each_line{ |s|
      current_line = s.split("|")
      current = {
        "date" => current_line[2],
        "title" => current_line[1],
        "link" => "#{@url}/#{current_line[0]}.html"
      }
      @posts << current
    }
    @posts
  end
  
end