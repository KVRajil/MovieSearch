require 'spec_helper'
RSpec.describe 'Movie', type: :request do
  let(:json_response) { JSON.parse(last_response.body).with_indifferent_access }

  describe 'GET /movies' do
    context 'Valid scenarios' do
      it 'should returns a list of movies without counter 0' do
        query = 'query=inception&include_adult=false&language=en-US&page=1'
        get("/movies?#{query}")
        expect(last_response.status).to eq(200)
        expect(json_response.keys).to match_array(%w[data counter])
        expect(json_response['counter']).to eq(0)
        expect(json_response['data'].keys).to match_array(%w[results page total_pages total_results])
      end

      it 'should returns a list of movies without counter 1' do
        query = 'query=inception&include_adult=false&language=en-US&page=1'
        get("/movies?#{query}")
        get("/movies?#{query}")
        expect(last_response.status).to eq(200)
        expect(json_response.keys).to match_array(%w[data counter])
        expect(json_response['counter']).to eq(1)
        expect(json_response['data'].keys).to match_array(%w[results page total_pages total_results])
      end
    end

    context 'Invalid scenarios' do
      it 'should throw error when we call the api without the query params' do
        query = ''
        get("/movies?#{query}")
        expect(last_response.status).to eq(422)
        expect(json_response.keys).to match_array(%w[error_message])
        expect(json_response['error_message']).to eq('Search query cannot be blank.')
      end
    end

  end
end



