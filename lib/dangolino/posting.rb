# encoding: utf-8

class Posting
  
  def initialize(year, month, link, file, title, input_format)
    
    conf = Dangolino_Config.new

    @year = year
    @month = month
    @link = link
    @file = file
    @title = title    
    @generate_dir = conf.generate_dir
    @post_date_published = DateTime.now.strftime("%d/%m/%Y - %H:%M:%S")
    @data_file = conf.lib_dir + "/dangolino/data/post_listing"
    @url = conf.url
    @input_format = input_format
  end
  
  def post_it
    year_dir = @generate_dir + File::SEPARATOR + @year
    month_dir = year_dir + File::SEPARATOR + @month
    new_path = month_dir + File::SEPARATOR + @file
    
    create_dir(year_dir)
    create_dir(month_dir)
    create_file(new_path, get_new_post_content)
  end
  
  private
  
  def create_file(new_path, post_content)
    post = {}
    post[:post_content] = post_content
    post[:post_title] = @title
    post[:post_date_published] = @post_date_published
    post[:post_url] = "#{@url}/#{@year}/#{@month}/#{@file}.html"
    comments = []
    current_post = Post.new(post,comments)

    File.open(new_path + ".html", "w:utf-8") do |f|
      f.puts current_post.render
    end
    tempfile = "/tmp/temp_post_listing"
    
    File.copy_stream(@data_file,tempfile)
    f = File.open(@data_file,'w')
    f.write("#{@year}/#{@month}/#{@file}|#{@title}|#{@post_date_published}\n#{File.open(tempfile,'r').read}")
    f.close
    File.delete(tempfile)
    
  end
  
  def get_new_post_content
    file_content = ""
    File.open(@link).each_line{ |s|
      file_content << s
    }
    
    if (@input_format == "markdown")
      markdown = MarkdownParser.new
      file_content = markdown.to_html(file_content)
    else
      file_content
    end
  end
  
  def create_dir(path)
    unless Dir.exists? (path)
      Dir.mkdir(path)
    end
  end
end