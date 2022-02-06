require_relative 'mini_twitter_client'
require'json'

def mini_twitter_client
  MiniTwitterClient.new
end

def read_order
  puts("Type number of order (or type/chose EXIT if you want to quit) end press ENTER: \n
        1. Create tweet \n
        2. Get and view an author tweets \n
        3. Get and view all tweets \n
        4. Delete tweet \n
        5. Delete author's tweets \n
        6. Delete all tweets \n
        0. Exit ")
  input = gets
  input.chop
end

def get_input(parameter)
  puts("Type tweet #{parameter} and press ENTER: \n")

  input = gets
  input.chop
end

def post_tweet
  name = get_input('name')
  email = get_input('email')
  message = get_input('message')

  created_tweet = mini_twitter_client.create_tweet(name, email, message)

  if created_tweet[:status] == 201
    puts("Success: \n Author: #{created_tweet[:data][:author][:name]} \n id: #{created_tweet[:data][:id]}")
  end
end

def disp_author_tweets
  name = get_input('name')
  mini_twitter_client.get_author_tweets(name).each do |tweet|
    puts("Author: #{tweet[:author][:name]}, email: #{tweet[:author][:email]}")
    puts("message: #{tweet[:message]}, id: #{tweet[:id]}")
  end
end

def disp_tweets
  mini_twitter_client.get_tweets[:data].each do |tweet|
    puts("Author: #{tweet[:author][:name]}, message: #{tweet[:message]}")
  end
end

def delete_tweet(id = nil)
  id = get_input('id') if id.nil?

  response = mini_twitter_client.del_tweet(id)

  puts("Tweet id: #{id} deleted.") if response.status == 204
end

def del_author_tweets
  name = get_input('authors name')
  mini_twitter_client.get_author_tweets(name).each { |tweet| delete_tweet(tweet[:id]) }
end

if __FILE__ == $0

  input = read_order

  until input.downcase == 'exit' || input.to_i.zero?

    case input.to_i
    when 1 then post_tweet
    when 2 then disp_author_tweets
    when 3 then disp_tweets
    when 4 then delete_tweet
    when 5 then del_author_tweets
    when 6 then mini_twitter_client.del_all_tweets
    end

    input = read_order
  end
end
