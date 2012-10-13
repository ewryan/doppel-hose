require 'rubygems'
require 'bundler'
require 'curb'
require 'json'
require 'awesome_print'
require 'resque'

module DoppelHose
  def self.ingest url, username, password
    Curl::Easy.http_get url do |c|
      c.http_auth_types = :basic
      c.username = username
      c.password = password

      c.encoding = "gzip"
      c.verbose = true

      c.on_body do |data|
        tweet = JSON.parse data

        entities = tweet["entities"]
        media = entities["media"] if entities
        media1 = media[0] if media
        media_url = media1["media_url_https"] if media1

        Resque.enqueue(IngestWorker, media_url, username) if media_url

        data.size # required by curl's api.
      end
    end
  end
end