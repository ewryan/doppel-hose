require 'bundler/setup'
require 'twitter'

class DoppelHose
  def self.ingest consumer_key, consumer_secret, access_token, access_token_secret

		client = Twitter::Streaming::Client.new do |config|
			config.consumer_key        = consumer_key
			config.consumer_secret     = consumer_secret
			config.access_token        = access_token
			config.access_token_secret = access_token_secret
		end

		client.sample do |object|
			if object.is_a?(Twitter::Tweet) && object.media?
				uri = object.media.first.media_uri_https.to_s
				Resque.enqueue(IngestWorker, uri, consumer_key) if uri
			end
		end
  end
end
