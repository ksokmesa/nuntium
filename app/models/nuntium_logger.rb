class NuntiumLogger
  
  def self.new(path, logger_name)
    if RUBY_PLATFORM.include?('mswin')
      require 'log4r'
      include Log4r
      
      pf = Log4r::PatternFormatter.new(:pattern => "%d %l %m")
      
      f = File.open(path, 'a')
      f.close
      logger = Log4r::Logger.new logger_name
      logger.level = INFO
      logger.add Log4r::RollingFileOutputter.new("#{logger_name}_outputter", :filename => path, :maxsize => 10 * 1024 * 1024, :formatter => pf)
      logger
    else
      logger = Logger.new(path)
      logger.formatter = Logger::Formatter.new
      logger
    end
  end

end