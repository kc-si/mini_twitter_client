class Response
  attr_reader :status, :data

  def initialize(status:, data:)
    @status = status
    @data = data
  end
end
