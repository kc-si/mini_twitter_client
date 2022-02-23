require 'active_record'
require_relative 'tweet'
require_relative 'author'
require_relative 'response'

class DbTweetsTable < ActiveRecord::Migration[7.0]
  def self.up
    create_table tweets_db do |t|
      t.string :author_name, null: false
      t.string :author_email, null: false
      t.text :message, null: false
    end
  end

  def self.down
    drop_table tweets_db
  end
end

class MiniTwitterPostgre
  attr_reader :conn

  def initialize
    @conn = ActiveRecord::Base.establish_connection(
      adapter: 'postgresql',
      host: 'localhost',
      username: 'sss',
      password: 'xxx',
      database: 'tweets',
    )
  end

  class TweetDb < ActiveRecord::Base
    self.table_name = 'tweets_db'
  end

  def get_tweets
    tweets = TweetDb.all
    tweets = tweets.map do |tweet|
      Tweet.build_from_db(tweet)
    end
    tweets ? status = 200 : return

    Response.new(status:, data: tweets)
  end

  def get_tweet(tweet_id)
    tweet = TweetDb.find_by(id: tweet_id)
    tweet ? status = 200 : return

    Response.new(status:, data: Tweet.build_from_db(tweet))
  end

  def create_tweet(author, message)
    tweet = TweetDb.create(
      author_name: author.name,
      author_email: author.email,
      message:,
    )
    tweet ? status = 201 : return

    Response.new(status:, data: Tweet.build_from_db(tweet))
  end

  def find_by_name(name)
    tweets = TweetDb.where(author_name: name)
    tweets.empty? ? return : status = 200

    tweets = tweets.map do |tweet|
      Tweet.build_from_db(tweet)
    end

    Response.new(status:, data: tweets)
  end

  def find_by_email(email)
    tweets = TweetDb.where(author_email: email)
    tweets.empty? ? return : status = 200

    tweets = tweets.map do |tweet|
      Tweet.build_from_db(tweet)
    end

    Response.new(status:, data: tweets)
  end

  def update_tweet(author, message, id)
    tweet = TweetDb.update(
      id,
      author_name: author.name,
      author_email: author.email,
      message:,
    )

    tweet ? status = 200 : return

    Response.new(status:, data: Tweet.build_from_db(tweet))
  end

  def delete_tweet(id)
    tweet = TweetDb.delete(id)
    status = 204 if tweet > 0

    Response.new(status:, data: tweet)
  end

  def delete_authors_tweets(name)
    tweets = TweetDb.delete_by(author_name: name)
    status = 204 if tweets > 0

    Response.new(status:, data: tweets)
  end

  def del_all_tweets
    TweetDb.delete_all
  end
end
