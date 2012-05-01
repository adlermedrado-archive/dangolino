# encoding: utf-8

class Wordpress
  def initialize
    conf = Dangolino_Config.new
    @generate_dir = conf.generate_dir
    @data_file = conf.lib_dir + "/dangolino/data/post_listing"
    @con = Sequel.mysql(:user=>conf.mysql_user, :password=>conf.mysql_pass, 
                        :host=>conf.mysql_host, :database=>conf.mysql_dbname)
    @url_site = conf.url
  end
  
  def import
    puts @con
    puts get_posts
  end
  
  private 
  def get_posts
    sql = "select wp_posts.ID, 
                  trim(wp_posts.post_content) as post_content, 
                  wp_posts.post_name, wp_posts.post_title,
    			        date_format(wp_posts.post_date, '%Y') as year, date_format(wp_posts.post_date, '%m') as month,
                  date_format(wp_posts.post_date, '%d/%m/%Y') post_date_published, wp_posts.post_type, wp_posts.post_status
			     from wp_posts
			     where wp_posts.post_status = 'publish'
			     and wp_posts.post_type = 'post'
			     order by wp_posts.post_date desc"
           
           @con.fetch(sql) do |post|
             comments = get_comments(post[:ID])
             post[:post_content] = post[:post_content].gsub("#{@url_site}/wp-content/uploads/", "#{@url_site}/images/")
             post[:post_url] = "#{@url_site}/#{post[:year]}/#{post[:month]}/#{post[:post_name]}.html"
             current_post = Post.new(post,comments)
             post_content = current_post.render
             
             unless Dir.exists? ("#{@generate_dir}/#{post[:year]}")
               Dir.mkdir("#{@generate_dir}/#{post[:year]}")
             end
             
             unless Dir.exists? ("#{@generate_dir}/#{post[:year]}/#{post[:month]}")
               Dir.mkdir("#{@generate_dir}/#{post[:year]}/#{post[:month]}")
             end
             
             File.open(where_to_save = @generate_dir + "/" + post[:year] + "/" + post[:month] + "/" + post[:post_name] + ".html", "w:utf-8") do |f|
               f.puts post_content
             end
             
             File.open(@data_file, "a:utf-8") do |f|
               f << "#{post[:year]}/#{post[:month]}/#{post[:post_name]}|#{post[:post_title]}|#{post[:post_date_published]}\n"
             end
             
           end           
  end
  
  private
  def get_comments(post_id)
    sql = "select wp_comments.comment_author, wp_comments.comment_ID,
                  trim(wp_comments.comment_author_url) as comment_author_url, 
                  date_format(wp_comments.comment_date, '%d/%m/%Y') as comment_date, 
                  wp_comments.comment_content, 
                  wp_posts.post_name, 
                  date_format(wp_posts.post_date, '%Y') as year, 
                  date_format(wp_posts.post_date, '%m') as month 
          from wp_comments, 
               wp_posts 
          where wp_comments.comment_approved <> 'spam' 
          and wp_comments.comment_post_ID = wp_posts.ID 
          and wp_posts.ID = #{post_id} order by comment_date_gmt ASC"
          @con.fetch(sql)
  end
end