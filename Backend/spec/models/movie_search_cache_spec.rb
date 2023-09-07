require 'spec_helper'

RSpec.describe MovieSearchCache, type: :model do
  let(:movie_search_cache) { create(:movie_search_cache, query_params: 'query=inception&include_adult=false&page=1') }

  context 'validations' do
    it 'ensures query_params presence' do
      movie_search_cache.query_params = nil
      expect(movie_search_cache).to_not be_valid
    end

    it 'ensures query_params uniqueness' do
      new_movie_search_cache = movie_search_cache.dup
      expect(new_movie_search_cache).to_not be_valid
    end
  end
end
