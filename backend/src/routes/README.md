# Routes

This directory contains API route definitions that map HTTP endpoints to controller methods.

## Purpose

Routes provide:
- URL endpoint definitions
- HTTP method mapping (GET, POST, PUT, DELETE)
- Middleware application
- Request parameter handling
- API versioning support
- Route organization by resource

## File Structure

```
routes/
├── auth.js              # Authentication routes
├── movies.js            # Movie-related routes
├── users.js             # User management routes
├── recommendations.js   # Recommendation routes
├── genres.js            # Genre-related routes
├── index.js             # Route aggregation and exports
└── api/                 # API versioning
    └── v1/
        ├── auth.js
        ├── movies.js
        └── users.js
```

## Route Pattern

Each route file follows a consistent pattern:

```javascript
// Example route structure
const express = require('express');
const router = express.Router();
const controller = require('../controllers/controllerName');
const middleware = require('../middleware');

// Apply middleware to all routes in this file
router.use(middleware.auth.optionalAuth);

// GET routes
router.get('/', controller.getAll);
router.get('/:id', controller.getById);

// POST routes
router.post('/', middleware.validation.validateCreate, controller.create);

// PUT routes
router.put('/:id', middleware.validation.validateUpdate, controller.update);

// DELETE routes
router.delete('/:id', controller.delete);

module.exports = router;
```

## Route Definitions

### `auth.js`
Authentication and user management endpoints.

**Endpoints:**
- `POST /auth/register` - User registration
- `POST /auth/login` - User login
- `POST /auth/logout` - User logout
- `POST /auth/refresh` - Refresh access token
- `POST /auth/forgot-password` - Password reset request
- `POST /auth/reset-password` - Password reset
- `POST /auth/verify-email` - Email verification

**Middleware:**
- Input validation
- Rate limiting
- CORS

### `movies.js`
Movie-related endpoints.

**Endpoints:**
- `GET /movies` - Get all movies (with pagination/filtering)
- `GET /movies/:id` - Get movie by ID
- `GET /movies/search` - Search movies
- `GET /movies/trending` - Get trending movies
- `GET /movies/popular` - Get popular movies
- `POST /movies/:id/rate` - Rate a movie
- `GET /movies/:id/similar` - Get similar movies

**Middleware:**
- Optional authentication
- Input validation
- Rate limiting

### `users.js`
User profile and preferences endpoints.

**Endpoints:**
- `GET /users/profile` - Get user profile
- `PUT /users/profile` - Update user profile
- `DELETE /users/profile` - Delete user account
- `GET /users/preferences` - Get user preferences
- `PUT /users/preferences` - Update user preferences
- `GET /users/watchlist` - Get user watchlist
- `POST /users/watchlist` - Add movie to watchlist
- `DELETE /users/watchlist/:movieId` - Remove movie from watchlist

**Middleware:**
- Authentication required
- Input validation
- Rate limiting

### `recommendations.js`
Movie recommendation endpoints.

**Endpoints:**
- `GET /recommendations` - Get personalized recommendations
- `GET /recommendations/trending` - Get trending recommendations
- `GET /recommendations/genre/:genreId` - Get genre-based recommendations
- `GET /recommendations/collaborative` - Get collaborative filtering results
- `GET /recommendations/content-based` - Get content-based recommendations

**Middleware:**
- Authentication required
- Input validation
- Rate limiting

### `genres.js`
Genre-related endpoints.

**Endpoints:**
- `GET /genres` - Get all genres
- `GET /genres/:id` - Get genre by ID
- `GET /genres/:id/movies` - Get movies by genre

**Middleware:**
- Optional authentication
- Input validation

## Route Parameters

Routes support various parameter types:

```javascript
// URL parameters
router.get('/movies/:id', controller.getMovie);

// Query parameters
router.get('/movies', controller.getMovies); // ?page=1&limit=10&genre=action

// Body parameters
router.post('/movies/:id/rate', controller.rateMovie);

// File uploads
router.post('/users/avatar', upload.single('avatar'), controller.uploadAvatar);
```

## Middleware Application

Routes can apply middleware at different levels:

```javascript
// Apply to all routes in file
router.use(middleware.auth.requireAuth);

// Apply to specific route
router.get('/profile', middleware.auth.requireAuth, controller.getProfile);

// Apply multiple middleware
router.post('/movies', 
  middleware.auth.requireAuth,
  middleware.validation.validateMovie,
  middleware.rateLimiter.limit(100),
  controller.createMovie
);
```

## API Versioning

Routes support versioning through the `api/` directory:

```javascript
// v1 routes
router.use('/api/v1/auth', require('./api/v1/auth'));
router.use('/api/v1/movies', require('./api/v1/movies'));

// v2 routes (future)
router.use('/api/v2/auth', require('./api/v2/auth'));
```

## Error Handling

Routes work with error handling middleware:

```javascript
// Route-specific error handling
router.get('/movies/:id', async (req, res, next) => {
  try {
    const movie = await controller.getMovie(req.params.id);
    if (!movie) {
      return res.status(404).json({ error: 'Movie not found' });
    }
    res.json(movie);
  } catch (error) {
    next(error);
  }
});
```

## Route Testing

Each route should have tests:
- Unit tests for individual endpoints
- Integration tests with Express app
- Test different HTTP methods
- Test parameter validation
- Test authentication requirements
- Test error scenarios

## Documentation

Routes should be documented with:
- Endpoint descriptions
- Request/response examples
- Parameter descriptions
- Authentication requirements
- Rate limiting information
- Error codes and messages

## Security Considerations

- Validate all inputs
- Sanitize user data
- Implement proper authentication
- Use HTTPS in production
- Rate limit sensitive endpoints
- Log security events 