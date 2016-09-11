module RequestHelpers
  def json
    raise 'Unable to convert empty response.body to JSON' if response.body.try(:blank?)
    JSON.parse(response.body)
  end
end
