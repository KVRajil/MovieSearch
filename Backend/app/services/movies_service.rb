class MoviesService
  attr_reader :query_params

  def initialize(query_params)
    @query_params = query_params
  end

  def search
    return blank_query_params if query_params.blank?

    if cached?
      update_cached_at
      update_counter
      success_response
    elsif fetch_movies[:success]
      find_or_create_movie_search_cache
      success_response
    else
      failed_response
    end
  end

  def movie_search_cache
    @_movie_search_cache ||= MovieSearchCache.find_by(query_params: query_params)
  end

  def cached?
    movie_search_cache && !movie_search_cache.expired?
  end

  def find_or_create_movie_search_cache
    cache           = MovieSearchCache.where(query_params: query_params).first_or_initialize
    cache.data    = fetch_movies[:data]
    cache.cached_at = Time.now
    cache.counter   = 0
    cache.save!
  end

  def update_counter
    movie_search_cache.increment!(:counter)
  end

  def update_cached_at
    movie_search_cache.update!(cached_at: Time.now)
  end

  def fetch_movies
    @_fetch_movies ||= MoviesClient.fetch_movies(query_params)
  end

  def success_response
    { response: { data: movie_search_cache.data, counter: movie_search_cache.counter }, status: :ok }
  end

  def failed_response
    { response: { error_message: fetch_movies[:error_message] }, status: fetch_movies[:status] }
  end

  def blank_query_params
    { response: { error_message: 'Search query cannot be blank.' }, status: :unprocessable_entity }
  end
end