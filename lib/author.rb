class Author
  attr_accessor :name
  attr_accessor :email

  def initialize(name: nil, email: nil)
    @name = name
    @email = email
  end

  def self.build_from_hash(author)
    Author.new(
        name: author['name'],
        email: author['email']
      )
  end
end
