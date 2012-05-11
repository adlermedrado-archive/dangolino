require "redcarpet"

class MarkdownParser
  
  def to_html(content)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
            :autolink => true, :space_after_headers => true)
            
    markdown.render(content)
  end
  
end