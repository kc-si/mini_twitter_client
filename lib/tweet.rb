class Author
  attr_accessor :name
  attr_accessor :email

  def initialize(name: nil, email: nil)
    @name = name
    @email = email
  end
end

class Tweet < Author
  def initialize(author:, message:, id:)
    @author = author
    @message = message
    @id = id
  end

  def author
    @author
  end
  def message
    @message
  end
  def id
    @id
  end

  def self.build_from_hash(tweet)
    Tweet.new(
      author: Author.new(
        name: tweet['author']['name'],
        email: tweet['author']['email']
      ),
      message: tweet['message'],
      id: tweet['id']
    )
  end
end
