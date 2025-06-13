'use client'

import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import { moviesApi } from '@/services/api/movies'

/**
 * Custom hook for fetching movie recommendations
 * @param {string} userId - User ID
 * @param {number} page - Page number
 * @returns {Object} Query result containing recommendations data and loading state
 */
export function useMovieRecommendations(userId, page = 1) {
  return useQuery({
    queryKey: ['recommendations', userId, page],
    queryFn: () => moviesApi.getRecommendations(userId, page),
    enabled: !!userId,
  })
}

/**
 * Custom hook for searching movies
 * @param {string} query - Search query
 * @param {number} page - Page number
 * @returns {Object} Query result containing search results and loading state
 */
export function useMovieSearch(query, page = 1) {
  return useQuery({
    queryKey: ['movieSearch', query, page],
    queryFn: () => moviesApi.searchMovies(query, page),
    enabled: !!query,
  })
}

/**
 * Custom hook for updating user preferences
 * @returns {Object} Mutation object for updating preferences
 */
export function useUpdatePreferences() {
  const queryClient = useQueryClient()

  return useMutation({
    mutationFn: ({ userId, preferences }) => 
      moviesApi.updateUserPreferences(userId, preferences),
    onSuccess: (_, { userId }) => {
      // Invalidate and refetch recommendations after preferences update
      queryClient.invalidateQueries(['recommendations', userId])
    },
  })
} 