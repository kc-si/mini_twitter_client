require_relative 'input_lib'
require 'faraday'
require 'json'

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

def create_tweet(author, message)
  connection.post { |post| post.body = { "tweet": { "author": author, "message": message } }.to_json }
end

def tweets
  response = connection.get

  JSON.parse(response.body)['data'].map do |tweet|
    {
      author: tweet['author'],
      id: tweet['id'],
      message: tweet['message']
    }
  end
end

def parse_tweets(author)
  tweets.select { |tweet| tweet[:author].downcase == author.downcase }
end

def post_tweet
  author = get_input('author')
  message = get_input('message')

  response = create_tweet(author, message)
  new_tweet(response)
end

def new_tweet(response)
  if [200, 201, 204].include?(response.status)
    id = response.headers[:location].split("/")[-1]

    new_tweet = tweets.select { |tweet| tweet[:id] == id }[0]

    puts("Success: \n Author : #{new_tweet[:author]}, message : #{new_tweet[:message]}") if id
  end
end

def read_author_tweets
  author = get_input('author')
  parse_tweets(author).each { |tweet| puts("Author : #{tweet[:author]}, message : #{tweet[:message]}, id : #{tweet[:id]}")
  }
end

def read_tweets
  tweets.each { |tweet| puts("Author : #{tweet[:author]}, message : #{tweet[:message]}") }
end

def del_tweet(id = nil)
  id = get_input('id') if id.nil?

  response = connection.delete(id)

  puts( "Tweet id: #{id} deleted." ) if [200, 201, 204].include?(response.status)
  response
end

def del_authors_tweets
  author = get_input('author')
  tweets.each { |tweet| tweet[:author] == author ? del_tweet(tweet[:id]) : nil }
end

def del_all_tweets
  tweets.each { |tweet| del_tweet(tweet[:id]) }
end

if __FILE__ == $0

  input = read_order

  until input.downcase == 'exit' || input.to_i.zero?

    case input.to_i
    when 1 then post_tweet
    when 2 then read_author_tweets
    when 3 then read_tweets
    when 4 then del_tweet
    when 5 then del_authors_tweets
    when 6 then del_all_tweets
    end

    input = read_order
  end
end
