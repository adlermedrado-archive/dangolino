# encoding: utf-8

require "mustache"

class Index < Mustache

  self.template_path = File.dirname(Dir.pwd) + "/templates"
  
  def initialize(data)
    @data = data
  end
  
  def title_1
    @data[0]['title']
  end
  
  def title_2
    @data[1]['title']
  end

  def title_3
    @data[2]['title']
  end
  
  def title_4
    @data[3]['title']
  end
  
  def link_1
    @data[0]['link']
  end
  
  def link_2
    @data[1]['link']
  end

  def link_3
    @data[2]['link']
  end
  
  def link_4
    @data[3]['link']
  end

  def date_1
    @data[0]['date']
  end
  
  def date_2
    @data[1]['date']
  end

  def date_3
    @data[2]['date']
  end
  
  def date_4
    @data[3]['date']
  end
  
  def itens
    @data
  end
end
