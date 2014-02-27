project_root = File.dirname(File.absolute_path(__FILE__))

require 'resque'
require 'resque/tasks'
require 'highline/import'
require 'yaml'
require "#{project_root}/lib/resque/ingest_worker"
require "#{project_root}/lib/doppel_hose"

desc "start downloading pictures"
task :ingest do
  config = YAML.load_file('config.yml')

  Resque.redis="127.0.0.1:6379"

  DoppelHose.ingest config["consumer_key"], config["consumer_secret"], config["access_token"], config["access_token_secret"]
end

