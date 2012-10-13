project_root = File.dirname(File.absolute_path(__FILE__))

require 'resque'
require 'resque/tasks'
require 'highline/import'
require "#{project_root}/lib/resque/ingest_worker"
require "#{project_root}/lib/doppel_hose"

desc "start downloading pictures"
task :ingest do
  username = ask("Enter your twitter username:  ")
  password = ask("Enter your twitter password:  ") { |q| q.echo = "x" }
  url ||= "https://stream.twitter.com/1/statuses/sample.json"
  Resque.redis="127.0.0.1:6379"

  DoppelHose.ingest url, username, password
end