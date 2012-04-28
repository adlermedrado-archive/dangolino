# encoding: utf-8

class Dangolino_Config

  attr_reader :root_dir, :generate_dir, :template_dir, :lib_dir, :url, :mysql_user, :mysql_host, :mysql_pass, :mysql_dbname
  
  def initialize
    parse
  end
  
  private
  def parse
    conf = YAML.load_file(File.dirname(Dir.pwd) + "/lib/dangolino/config/settings.yml")
    @root_dir = conf["path"]["root_dir"]
    @generate_dir = conf["path"]["generate_dir"]
    @tempalte_dir = conf["path"]["template_dir"]
    @lib_dir = conf["path"]["lib_dir"]
    @url = conf["path"]["url"]    
    @mysql_user = conf["mysql"]["user"]
    @mysql_host = conf["mysql"]["host"]
    @mysql_pass = conf["mysql"]["pass"]    
    @mysql_dbname = conf["mysql"]["dbname"]
  end
end