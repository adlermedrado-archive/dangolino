module CLI extend OptiFlagSet
  flag "year"
  flag "month"
  flag "file"
  flag "link"
  flag "title"
  optional_flag "format"
  optional_flag "config"  
  usage_flag "help"
  and_process!
end

if ARGV.flags.format?
  if ARGV.flags.format == "markdown"
    $input_format = ARGV.flags.format
  else
    $input_format = "html"
  end
else
  $input_format = "html"
end

if ARGV.flags.config?
  $settings_file = ARGV.flags.config
else
  $settings_file = "settings.yml"
end
