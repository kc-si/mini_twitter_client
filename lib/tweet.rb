require_relative 'author'

class Tweet
  attr_reader :author, :message, :id

  def initialize(author:, message:, id:)
    @author = author
    @message = message
    @id = id
  end

  def self.build_from_hash(tweet)
    Tweet.new(
      author: Author.build_from_hash(tweet['author']),
      message: tweet['message'],
      id: tweet['id'],
    )
  end

  def self.build_from_db(tweet)
    Tweet.new(
      author: Author.build_from_db(tweet),
      message: tweet.message,
      id: tweet.id,
    )
  end
end
