class MovieSearchCache < ApplicationRecord

  validates :query_params, presence: true, uniqueness: true

  def expired?
    Time.now - cached_at > MOVIE_SEARCH_CACHE_TTL
  end
end
