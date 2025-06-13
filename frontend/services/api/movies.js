import { apiClient } from './client'

/**
 * @typedef {Object} Movie
 * @property {string} id - Movie unique identifier
 * @property {string} title - Movie title
 * @property {string} overview - Movie description
 * @property {string} poster_path - URL to movie poster
 * @property {string} release_date - Movie release date
 * @property {number} vote_average - Average rating
 * @property {string[]} genres - List of movie genres
 */

/**
 * @typedef {Object} PaginatedResponse
 * @property {Movie[]} data - Array of movies
 * @property {number} page - Current page number
 * @property {number} totalPages - Total number of pages
 * @property {number} totalResults - Total number of results
 * @property {number} status - HTTP status code
 * @property {string} [message] - Optional response message
 */

export const moviesApi = {
  /**
   * Get movie recommendations for a user
   * @param {string} userId - User ID
   * @param {number} [page=1] - Page number
   * @returns {Promise<PaginatedResponse>}
   */
  getRecommendations: async (userId, page = 1) => {
    const response = await apiClient.get(`/api/recommendations/${userId}?page=${page}`)
    return response.data
  },

  /**
   * Get detailed information about a movie
   * @param {string} movieId - Movie ID
   * @returns {Promise<Movie>}
   */
  getMovieDetails: async (movieId) => {
    const response = await apiClient.get(`/api/movies/${movieId}`)
    return response.data
  },

  /**
   * Search for movies
   * @param {string} query - Search query
   * @param {number} [page=1] - Page number
   * @returns {Promise<PaginatedResponse>}
   */
  searchMovies: async (query, page = 1) => {
    const response = await apiClient.get(`/api/movies/search?q=${query}&page=${page}`)
    return response.data
  },

  /**
   * Update user movie preferences
   * @param {string} userId - User ID
   * @param {Object} preferences - User preferences
   * @param {string[]} preferences.favoriteGenres - List of favorite genres
   * @returns {Promise<void>}
   */
  updateUserPreferences: async (userId, preferences) => {
    await apiClient.put(`/api/users/${userId}/preferences`, preferences)
  }
} 