class Tweet
  def initialize(name:, email:, message:, id:)
    @name = name
    @email = email
    @message = message
    @id = id
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

  def self.build_from_hash(tweet)
    Tweet.new(
      name: tweet['author']['name'],
      email: tweet['author']['email'],
      message: tweet['message'],
      id: tweet['id']
    )
  end
end
