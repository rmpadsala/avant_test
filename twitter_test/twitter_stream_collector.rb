require 'tweetstream'
require_relative 'frequent_words_mgr'

module AvantTest
  class TwitterStreamCollector
    attr_reader :words_hash

    IGNORE_WORDS_LIST = ["i", "we", "you", "they", "the", "and", "or", "your",
      "is", "a", "are", "for", "when", "has", "have", "like", "me", "it", "how",
      "what", "my", "he", "she", "to", "of", "be", "this", "that", "their", "there",
      "on"].sort

    def initialize
      TweetStream.configure do |config|
        config.consumer_key       = 'D96UzR8D3UGgWQ1TJDEMa1vCu'
        config.consumer_secret    = 'ViznlPNuSZQ6oMtjM7yuYS6AFrgUWyLeMuTrJHR5p4ZohZcBMJ'
        config.oauth_token        = '91525495-TeMTP0bOjTU16g3Lb8Sq8NPVcpQNGYVmIyEoipctS'
        config.oauth_token_secret = 'kHqGDbAetkbBCCEPopj6ZUedkn2JsOtyCvnDz71suZd56'
        config.auth_method        = :oauth
      end

      @client = TweetStream::Client.new
      @words_hash = Hash.new(0)
    end

    def frequent_words
      collect_sample_tweets
      FrequentWordsMgr.new(@words_hash).frequent_words
    end

    private
      def collect_sample_tweets(default_minutes=5)
        tweets = []
        EM.run do
          # do something on an interval
          @client.sample do |status|
            # The status object is a special Hash with
            # method access to its keys.
            tweets << "#{status.text}"
            puts "collected #{tweets.size} tweets" if (tweets.size % 1000).zero?
          end

          EM::PeriodicTimer.new(default_minutes*60) do
            @client.stop
            process_tweets(tweets)
          end
        end
      end

      def process_tweets(tweets)
        puts "size #{tweets.size}"
        tweets.each { |tweet|
          words = tweet.split
          words.each { |word|
            @words_hash[word] += 1 unless IGNORE_WORDS_LIST.include?(word.downcase)
          }
        }
      end
  end
end
