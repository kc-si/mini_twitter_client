class Response
  def initialize(status:, data:)
    @status = status
    @data = data
  end

  def status
    @status
  end

  def data
    @data
  end
end
