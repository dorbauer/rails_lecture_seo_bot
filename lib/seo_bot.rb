class SeoBot
  
  require 'helper_modules.rb'
  
  include Config
  include FileOpener
  include FileDownloader
  
  def initialize
    @google_ip_list = download_file(GOOGLE_IP_LIST_ADDRESS)
    @log_file_lines = open_server_log(LOG_FILE_PATH)
    @ip_regexp = IP_REGEXP
    @ua_regexp = UA_REGEXP
    @result = Array.new()
  end
  
  def parse_log_file
    @log_file_lines.each do |row|
      print_line(row) unless !match?(row.to_s)
    end
    puts "Google was here #{@result.size} times"
  end
  
  def match?(row)
    @google_ip_list.each do |row2|
      comparator = get_comparator(row2.to_s)
      return true unless !(comparator != nil && row.include?(comparator))
    end
    return false
  end
  
  def get_comparator(row_string)
    return row_string unless !row_string.match(@ip_regexp)
    return row_string.match(@ua_regexp)[1] unless !row_string.match(@ua_regexp)
    return nil
  end
  
  def print_line(row)
    @result.push(row)
  end
  
end

seoB = SeoBot.new()
seoB.parse_log_file