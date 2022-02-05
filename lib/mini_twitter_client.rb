require 'faraday'
require 'json'

class MiniTwitterClient
  def connection
    Faraday.new(
      url: 'http://localhost:4000/api/tweets',
      params: {},
      headers: {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }
    )
  end

  def get_tweets
    res = connection.get
    data = JSON.parse(res.body)['data'].map do |tweet|
      {
        author: tweet['author'],
        id: tweet['id'],
        message: tweet['message']
      }
    end

    {
      status: res.status.to_i,
      data:
    }
  end

  def create_tweet(author, message)
    res = connection.post { |post| post.body = { "tweet": { "author": author, "message": message } }.to_json }
    tweet = JSON.parse(res.body)['data']

    {
      status: res.status.to_i,
      data: {
        author: tweet['author'],
        id: tweet['id'],
        message: tweet['message']
      }
    }
  end

  def del_tweet(id)
    connection.delete(id)
  end

  def del_all_tweets
    get_tweets[:data].each { |tweet| del_tweet(tweet[:id]) }
  end

  def get_author_tweets(author)
    get_tweets[:data].select { |tweet| tweet[:author] == author }
  end
end
