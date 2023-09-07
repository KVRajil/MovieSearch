class MoviesController < ApplicationController

  # GET /movies
  get '/movies' do
    response = MoviesService.new(request.query_string).search
    data   = response[:response]
    status = response[:status]

    json_response(data, status)
  end
end