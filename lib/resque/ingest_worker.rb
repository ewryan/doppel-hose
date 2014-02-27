require 'rubygems'
require 'bundler'
require 'curb'
require 'fileutils'

class IngestWorker
  @queue = :default

  def self.perform(url, username)
    local_data_dir = "pics"
    local_filename = url[(url.rindex("/"))..-1]
    FileUtils.mkdir_p local_data_dir

    result = Curl::Easy.http_get(url) { |e| e.useragent = "Ruby/Curb - github.com/ericwryan/doppel-hose - twitter_consumer_key:#{username}" }
    puts "Received #{result.response_code} for url '#{url}"
    File.open("#{local_data_dir}/#{local_filename}", 'w') { |f| f.write(result.body_str) }
  end
end
