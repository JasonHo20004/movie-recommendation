# Services

This directory contains business logic services that handle complex operations, external API integrations, and data processing.

## Purpose

Services provide:
- Business logic implementation
- External API integrations
- Data processing and transformation
- Recommendation algorithms
- Caching and optimization
- Complex database operations

## File Structure

```
services/
├── authService.js        # Authentication business logic
├── movieService.js       # Movie data operations
├── recommendationService.js  # Recommendation algorithms
├── userService.js        # User management logic
├── tmdbService.js        # The Movie Database API integration
├── cacheService.js       # Caching operations
├── emailService.js       # Email notifications
└── index.js              # Service exports
```

## Service Pattern

Each service follows a consistent pattern:

```javascript
// Example service structure
const someModel = require('../models/SomeModel');
const externalApi = require('../utils/externalApi');

class ServiceName {
  // Instance method
  async methodName(params) {
    try {
      // Business logic implementation
      const result = await this.processData(params);
      return result;
    } catch (error) {
      throw new Error(`Service error: ${error.message}`);
    }
  }

  // Private method
  async processData(params) {
    // Internal processing logic
  }

  // Static method
  static async staticMethod(params) {
    // Static utility method
  }
}

module.exports = new ServiceName();
```

## Service Definitions

### `authService.js`
Authentication and authorization business logic.

**Methods:**
- `register(userData)` - User registration with validation
- `login(credentials)` - User login with JWT token generation
- `logout(token)` - Token invalidation
- `refreshToken(refreshToken)` - Generate new access token
- `resetPassword(email)` - Password reset process
- `verifyEmail(token)` - Email verification
- `changePassword(userId, oldPassword, newPassword)` - Password change

**Features:**
- Password hashing with bcrypt
- JWT token management
- Email verification
- Password reset flow
- Session management

### `movieService.js`
Movie data operations and management.

**Methods:**
- `getMovies(filters, pagination)` - Get movies with filtering
- `getMovieById(id)` - Get movie details
- `searchMovies(query, filters)` - Search movies
- `getTrendingMovies()` - Get trending movies
- `getPopularMovies()` - Get popular movies
- `getSimilarMovies(movieId)` - Get similar movies
- `rateMovie(userId, movieId, rating)` - Rate a movie
- `addToWatchlist(userId, movieId)` - Add to watchlist

**Features:**
- Database operations
- Data validation
- Caching integration
- External API synchronization

### `recommendationService.js`
Movie recommendation algorithms and logic.

**Methods:**
- `getPersonalizedRecommendations(userId)` - User-specific recommendations
- `getCollaborativeRecommendations(userId)` - Collaborative filtering
- `getContentBasedRecommendations(userId)` - Content-based filtering
- `getGenreRecommendations(genreId, userId)` - Genre-based recommendations
- `getTrendingRecommendations()` - Trending recommendations
- `updateUserPreferences(userId, preferences)` - Update user preferences

**Algorithms:**
- Collaborative filtering (user-based, item-based)
- Content-based filtering
- Hybrid recommendations
- Matrix factorization
- Neural network recommendations

### `userService.js`
User management and profile operations.

**Methods:**
- `getUserProfile(userId)` - Get user profile
- `updateUserProfile(userId, updates)` - Update profile
- `deleteUser(userId)` - Delete user account
- `getUserPreferences(userId)` - Get user preferences
- `updateUserPreferences(userId, preferences)` - Update preferences
- `getUserWatchlist(userId)` - Get user watchlist
- `getUserRatings(userId)` - Get user ratings

**Features:**
- Profile management
- Preference tracking
- Watchlist management
- Rating history

### `tmdbService.js`
The Movie Database API integration.

**Methods:**
- `searchMovies(query)` - Search TMDB for movies
- `getMovieDetails(tmdbId)` - Get movie details from TMDB
- `getTrendingMovies()` - Get trending movies from TMDB
- `getPopularMovies()` - Get popular movies from TMDB
- `getMovieCredits(tmdbId)` - Get movie credits
- `getSimilarMovies(tmdbId)` - Get similar movies from TMDB

**Features:**
- API rate limiting
- Response caching
- Error handling
- Data transformation
- Image URL processing

### `cacheService.js`
Caching operations and management.

**Methods:**
- `get(key)` - Get cached data
- `set(key, value, ttl)` - Set cached data with TTL
- `delete(key)` - Delete cached data
- `clear()` - Clear all cached data
- `getOrSet(key, fetchFunction, ttl)` - Get or fetch and cache

**Features:**
- Redis integration
- Memory caching fallback
- TTL management
- Cache invalidation
- Performance monitoring

### `emailService.js`
Email notification and communication.

**Methods:**
- `sendWelcomeEmail(user)` - Welcome email
- `sendPasswordResetEmail(user, token)` - Password reset email
- `sendEmailVerification(user, token)` - Email verification
- `sendRecommendationEmail(user, recommendations)` - Recommendation email

**Features:**
- Email template management
- SMTP configuration
- Email queuing
- Delivery tracking
- Template personalization

## Service Dependencies

Services can depend on each other:

```javascript
// Example service dependency
const movieService = require('./movieService');
const cacheService = require('./cacheService');

class RecommendationService {
  async getRecommendations(userId) {
    // Use other services
    const userRatings = await movieService.getUserRatings(userId);
    const cachedRecommendations = await cacheService.get(`rec_${userId}`);
    
    if (cachedRecommendations) {
      return cachedRecommendations;
    }
    
    // Generate recommendations
    const recommendations = await this.generateRecommendations(userRatings);
    
    // Cache results
    await cacheService.set(`rec_${userId}`, recommendations, 3600);
    
    return recommendations;
  }
}
```

## Error Handling

Services implement comprehensive error handling:

```javascript
class ServiceName {
  async methodName(params) {
    try {
      // Service logic
    } catch (error) {
      // Log error
      logger.error('Service error:', error);
      
      // Transform error for API response
      if (error.name === 'ValidationError') {
        throw new BadRequestError(error.message);
      }
      
      if (error.name === 'NotFoundError') {
        throw new NotFoundError('Resource not found');
      }
      
      // Re-throw unexpected errors
      throw new InternalServerError('An unexpected error occurred');
    }
  }
}
```

## Testing Services

Each service should have comprehensive tests:
- Unit tests for individual methods
- Integration tests with dependencies
- Mock external API calls
- Test error scenarios
- Performance testing
- Cache testing

## Performance Considerations

- Implement caching strategies
- Use database indexing
- Optimize database queries
- Implement rate limiting
- Monitor service performance
- Use connection pooling 