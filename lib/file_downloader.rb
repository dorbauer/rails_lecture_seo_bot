module FileDownloader
  
  require 'net/http'
  require 'uri'
  
  def download_file(address)
    
    puts "Donwloading google ip list file"
    
    uri = URI.parse(address)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    request.initialize_http_header({"User-Agent" => "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; WOW64; Trident/4.0; SLCC2; Media Center PC 6.0; InfoPath.2; MS-RTC LM "})
    response = http.request request

    raise "Could not download the file" unless response.kind_of? Net::HTTPSuccess
    return response.body
  end
  
end

module FileOpener
  
  def open_server_log(path)
     
     puts "Opening server log file"
     
     raise IOError, 'File_path is nil' unless path != nil
     raise IOError, 'File_path is not existing' unless File.exist?(path) 
     raise IOError, 'File_path is not readable' unless File.readable?(path) 
     
     log = File.open(path, "r")
     lines = log.readlines
     log.close
     return lines
  end
  
end

module Config
  
  puts "Including Config module !"
  
  GOOGLE_IP_LIST_ADDRESS = "http://www.iplists.com/nw/google.txt"
  LOG_FILE_PATH = "../log/apache-combined.log"
  IP_REGEXP = /(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})/
  UA_REGEXP = /^# UA "(.*)"$/
  
end
