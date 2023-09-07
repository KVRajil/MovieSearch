class MoviesClient
  include HTTParty
  base_uri "#{TMDB_HOST}"

  def self.fetch_movies(query)
    begin
      headers  = { 'Authorization' => "Bearer #{TMDB_ACCESS_TOKEN}" }
      response = get("/3/search/movie?#{query}", headers: headers)
      if response.success?
        { success: true, data: response.parsed_response, status: response.code }
      else
        { success: false, error_message: "API Error: #{response.message}", status: response.code }
      end
    rescue StandardError => e
      { success: false, error_message: "Unexpected error: #{e.message}", status: 500 }
    end
  end
end
