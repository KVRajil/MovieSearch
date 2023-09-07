class ApplicationController < MovieSearch

  def json_response(data, status)
    content_type :json
    status status
    data.to_json
  end
end
