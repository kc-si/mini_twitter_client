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

  def fetch_tweets
    response = connection.get

    JSON.parse(response.body)['data'].map do |tweet|
      {
        author: tweet['author'],
        id: tweet['id'],
        message: tweet['message']
      }
    end
  end

  def create_tweet(author, message)
    connection.post { |post| post.body = { "tweet": { "author": author, "message": message } }.to_json }
  end

  def del_tweet(id)
    connection.delete(id)
  end

  def del_all_tweets
    fetch_tweets.each { |tweet| del_tweet(tweet[:id]) }
  end

  def parse_tweets(author)
    fetch_tweets.select { |tweet| tweet[:author].downcase == author.downcase }
  end
end
