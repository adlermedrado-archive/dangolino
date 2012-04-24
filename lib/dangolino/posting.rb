# encoding: utf-8

class Posting
  
  def initialize(year, month, link, file, title)
    @year = year
    @month = month
    @link = link
    @file = file
    @title = title    
    @generate_dir = File.dirname(Dir.pwd) + "/generated"
    @post_date_published = DateTime.now.strftime("%d/%m/%Y - %H:%M:%S")
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
    comments = []
    current_post = Post.new(post,comments)
    # post_content = current_post.render
    File.open(new_path + ".html", "w:utf-8") do |f|
      f.puts current_post.render
    end
  end
  
  def get_new_post_content
    file_content = ""
    File.open(@link).each_line{ |s|
      file_content << s
    }
    file_content
  end
  
  def create_dir(path)
    unless Dir.exists? (path)
      Dir.mkdir(path)
    end
  end
end