require_relative 'mini_twitter_client'
require 'json'

class CLI
  def initialize
    @mini_twitter_client = MiniTwitterClient.new
  end

  def read_order
    puts("Type number of order (or type/chose EXIT if you want to quit) end press ENTER: \n
          1. Create tweet \n
          2. Get and view an author tweets \n
          3. Get and view all tweets \n
          4. Update tweet \n
          5. Delete tweet \n
          6. Delete author's tweets \n
          7. Delete all tweets \n
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

    created_tweet = @mini_twitter_client.create_tweet(name, email, message)

    if created_tweet[:status] == 201
      puts("Success: \n Author: #{created_tweet[:data].name} \n id: #{created_tweet[:data].id}")
    end
  end

  def get_author_tweets(name)
    @mini_twitter_client.get_tweets[:data].select { |tweet| tweet.name == name }
  end

  def disp_author_tweets
    name = get_input('name')
    get_author_tweets(name).each do |tweet|
      puts("Author: #{tweet.name}, email: #{tweet.email}")
      puts("message: #{tweet.message}, id: #{tweet.id}")
    end
  end

  def disp_tweets
    @mini_twitter_client.get_tweets[:data].each do |tweet|
      puts("Author: #{tweet.name}, message: #{tweet.message}")
    end
  end

  def upd_tweet
    id = get_input('id')
    name = get_input('name')
    email = get_input('email')
    message = get_input('message')

    response = @mini_twitter_client.update_tweet(name, email, message, id)

    puts("Tweet id: #{id} updated.") if response[:status] == 200
  end

  def del_tweet(id = nil)
    id = get_input('id') if id.nil?

    response = @mini_twitter_client.delete_tweet(id)
    puts("Tweet id: #{id} deleted.") if response[:status] == 204
  end

  def del_author_tweets
    name = get_input('authors name')
    get_author_tweets(name).each { |tweet| del_tweet(tweet.id) }
  end

  def del_all_tweets
    @mini_twitter_client.get_tweets[:data].each { |tweet| @mini_twitter_client.delete_tweet(tweet.id) }
    puts('Tweets deleted')
  end
end

if __FILE__ == $0

  cli = CLI.new

  input = cli.read_order

  until input.downcase == 'exit' || input.to_i.zero?

    case input.to_i
    when 1 then cli.post_tweet
    when 2 then cli.disp_author_tweets
    when 3 then cli.disp_tweets
    when 4 then cli.upd_tweet
    when 5 then cli.del_tweet
    when 6 then cli.del_author_tweets
    when 7 then cli.del_all_tweets
    end

    input = cli.read_order
  end
end
