<template>
  <div>
    <h1>Movie Search</h1>
    <div>
      <input v-model="query" placeholder="Search for movies" />
      <button @click="searchMovies">Search</button>
    </div>
    <div class="message">
      <div v-if="counter === 0" class="message-api">Result from API</div>
      <div v-else class="message-cache">Result from Cache  count - {{ counter }}</div>
    </div>
    <div class="movie-list">
      <div v-for="movie in movies" :key="movie.id" class="movie-card">
        <img :src="'https://image.tmdb.org/t/p/w185/' + movie.poster_path" :alt="movie.title" />
        <p class="movie-title">{{ movie.title }}</p>
      </div>
    </div>
    <button class="next-page-button" v-if="totalPages > 1 && page < totalPages" @click="loadNextPage">Next Page</button>
  </div>
</template>


<script>
export default {
  data() {
    return {
      query: 'inception',
      page: 1,
      movies: [],
      totalPages: 0,
    };
  },
  methods: {
    fetchMovies() {
      const apiUrl = `http://localhost:3000/movies?query=${this.query}&include_adult=false&language=en-US&page=${this.page}`;

      fetch(apiUrl)
        .then((response) => response.json())
        .then((data) => {
          this.counter = data.counter
          data = data.data
          this.movies = [...this.movies, ...data.results]
          this.page = data.page
          this.totalPages = data.total_pages;
        })
        .catch((error) => console.error('Error fetching movies:', error));
    },
    searchMovies() {
      this.page = 1;
      this.movies = [];
      this.fetchMovies();
    },
    loadNextPage() {
      if (this.page < this.totalPages) {
        this.page += 1;
        this.fetchMovies();
      }
    },
  },
  created() {
    this.fetchMovies();
  },
};
</script>



<style>
.movie-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
  gap: 20px;
  padding: 20px;
}

.movie-card {
  background-color: #333;
  border-radius: 10px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  overflow: hidden;
  text-align: center;
}

.movie-card img {
  max-width: 100%;
  height: auto;
}

.movie-title {
  color: #fff;
  font-size: 1.2rem;
  padding: 10px;
}

.message {
  margin-bottom: 20px;
  margin-top: 20px;
  width: 230px;
}
.message-api {
  border: 2px solid red;
  padding: 10px;
  color: red;
}

.message-cache {
  border: 2px solid green;
  padding: 10px;
  color: green;
}

.next-page-button{
  margin-bottom: 100px;
  margin-top: 30px;
  background-color: #007BFF;
  color: #fff;
  border: none;
  border-radius: 5px;
  padding: 10px 20px;
  cursor: pointer;
  font-size: 16px;
}
</style>
