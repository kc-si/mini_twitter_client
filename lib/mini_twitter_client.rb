require 'faraday'
require 'json'

class Tweet
  def initialize(name = 'name', email = 'email@email.com', message = 'message', id = nil)
    @name = name
    @email = email
    @message = message
    @id =id
  end
  def name
    @name
  end
  def email
    @email
  end
  def message
    @message
  end
  def id
    @id
  end
end

class MiniTwitterClient
  def initialize
    @connection = Faraday.new(
      url: 'http://localhost:4000',
      params: {},
      headers: {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }
    )
  end

  def get_tweets
    res = @connection.get('/api/tweets')
    data = JSON.parse(res.body)['data'].map do |tweet|
      Tweet.new(tweet['author']['name'], tweet['author']['email'], tweet['message'], tweet['id'])
    end

    {
      status: res.status.to_i,
      data:
    }
  end

  def create_tweet(name, email, message)
    res = @connection.post('/api/tweets') do |post|
      post.body = { "tweet": { "author": { "name": name, "email": email }, "message": message } }.to_json
    end
    tweet = JSON.parse(res.body)['data']

    {
      status: res.status.to_i,
      data: Tweet.new(tweet['author']['name'], tweet['author']['email'], tweet['message'], tweet['id'])
    }
  end

  def delete_tweet(id)
    res = @connection.delete("/api/tweets/#{id}")

    {
      status: res.status.to_i,
      data: Tweet.new()
    }
  end

  def update_tweet(name, email, message, id)
    res = @connection.put("/api/tweets/#{id}") do |put|
      put.body = { "tweet": { "author": { "name": name, "email": email }, "message": message, "id": id } }.to_json
    end
    tweet = JSON.parse(res.body)['data']

    {
      status: res.status.to_i,
      data: Tweet.new(tweet['author']['name'], tweet['author']['email'], tweet['message'], tweet['id'])
    }
  end
end
