require './lib/mini_twitter_client'
require 'debug'

RSpec.describe 'methods of mini_twitter_client class: create_tweet(author, massage) and delete_tweet(id)' do
  it ' creates new tweet and delete it ' do
    author = 'Johan'
    message = 'Test tweet :)'

    def mini_twitter_client
      MiniTwitterClient.new
    end

    response = mini_twitter_client.create_tweet(author, message)

    response = mini_twitter_client.del_tweet(response[:data][:id])

    expect(response.status).to eq(204)
  end
end
