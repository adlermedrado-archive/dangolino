# encoding: utf-8

class Dangolino_Config

  attr_reader :root_dir, :generate_dir, :template_dir, :lib_dir, :datafile, :url, :mysql_user, :mysql_host, :mysql_pass, :mysql_dbname
  
  def initialize(settings_file)
    @settings_file = settings_file
    parse
  end
  
  private
  def parse
    config_path = File.expand_path(File.dirname(__FILE__))
    config_path = config_path.gsub('/bin', '/lib')
    # conf = YAML.load_file(File.dirname(Dir.pwd) + "/lib/dangolino/config/settings.yml")
    conf = YAML.load_file("#{config_path}/#{@settings_file}")
    @root_dir = conf["path"]["root_dir"]
    @generate_dir = conf["path"]["generate_dir"]
    @tempalte_dir = conf["path"]["template_dir"]
    @lib_dir = conf["path"]["lib_dir"]
    @datafile = conf["path"]["datafile"]
    @url = conf["path"]["url"]    
    @mysql_user = conf["mysql"]["user"]
    @mysql_host = conf["mysql"]["host"]
    @mysql_pass = conf["mysql"]["pass"]    
    @mysql_dbname = conf["mysql"]["dbname"]
  end
end