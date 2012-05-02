require "redcarpet"

class MarkdownParser
  
  def to_html(content)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
            :autolink => true, :space_after_headers => true)
            
    markdown.render(content)
  end
  
end

# require "redcarpet"
# 
# markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
#         :autolink => true, :space_after_headers => true)
# 
# file_content = ""
#   File.open('exemplo.markdown').each_line{ |s|
#     file_content << s
#   }
# # puts file_content        
# puts markdown.render(file_content)
