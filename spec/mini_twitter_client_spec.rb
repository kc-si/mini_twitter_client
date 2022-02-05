require './lib/mini_twitter_client'

RSpec.describe 'methods of mini_twitter_client class: create_tweet(author, massage) and delete_tweet(id)' do
  it ' creates new tweet and delete it ' do
    author = 'Johan'
    message = 'Test tweet :)'

    def mini_twitter_client
      MiniTwitterClient.new
    end

    res = []
    response = mini_twitter_client.create_tweet(author, message)
    res << 200 if [200, 201, 204].include?(response.status)

    id = response.headers[:location].split("/")[-1]

    response = mini_twitter_client.del_tweet(id)

    res << 200 if [200, 201, 204].include?(response.status)

    expect(res).to eq([200, 200])
  end
end
