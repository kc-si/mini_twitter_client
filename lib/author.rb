class Author
  attr_reader :name, :email

  def initialize(name:, email:)
    @name = name
    @email = email
  end

  def self.build_from_hash(author)
    Author.new(
      name: author['name'],
      email: author['email'],
    )
  end
end
