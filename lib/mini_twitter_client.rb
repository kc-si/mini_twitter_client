require 'faraday'
require 'json'
require_relative 'tweet'

class Response
  def initialize(status:, data:)
    @status = status
    @data = data
  end

  def status
    @status
  end
  def data
    @data
  end
end

class MiniTwitterClient
  def initialize
    @connection = Faraday.new(
      url: 'http://localhost:4000',
      headers: {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }
    )
  end

  def get_tweets
    res = @connection.get('/api/tweets')
    tweets = JSON.parse(res.body)['data'].map do |tweet|
      Tweet.build_from_hash(tweet)
    end

    Response.new(status: res.status.to_i, data: tweets)
  end

  def get_tweet(tweet_id)
    res = @connection.get("/api/tweets/#{tweet_id}")
    tweet = JSON.parse(res.body)['data']

    Response.new(status: res.status.to_i, data: Tweet.build_from_hash(tweet))
  end

  def create_tweet(author, message)
    body = {
      "tweet": {
        "author": {
          "name": author.name,
          "email": author.email
        },
        "message": message
      }
    }.to_json
    res = @connection.post('/api/tweets', body)
    tweet = JSON.parse(res.body)['data']

    Response.new(status: res.status.to_i, data: Tweet.build_from_hash(tweet))
  end

  def delete_tweet(id)
    res = @connection.delete("/api/tweets/#{id}")

    Response.new(status: res.status.to_i, data: nil)
  end

  def update_tweet(author, message, id)
    body = {
      "tweet": {
        "author": {
          "name": author.name,
          "email": author.email
        },
        "message": message,
        "id": id
        }
      }.to_json
    res = @connection.put("/api/tweets/#{id}", body)
    tweet = JSON.parse(res.body)['data']

    Response.new(status: res.status.to_i, data: Tweet.build_from_hash(tweet))
  end
end
