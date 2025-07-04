# Controllers

This directory contains request handlers (controllers) that process incoming HTTP requests and return appropriate responses.

## Purpose

Controllers act as the bridge between routes and business logic. They:
- Extract and validate request data
- Call appropriate services for business logic
- Format and return responses
- Handle errors and edge cases

## File Structure

```
controllers/
├── authController.js      # Authentication-related handlers
├── movieController.js     # Movie-related handlers
├── userController.js      # User management handlers
├── recommendationController.js  # Recommendation algorithm handlers
└── index.js              # Controller exports
```

## Controller Pattern

Each controller follows a consistent pattern:

```javascript
// Example controller structure
const someService = require('../services/someService');

const controllerName = {
  // GET handler
  async getMethod(req, res, next) {
    try {
      const { param1, param2 } = req.params;
      const { query1, query2 } = req.query;
      
      const result = await someService.method(param1, param2);
      
      res.status(200).json({
        success: true,
        data: result
      });
    } catch (error) {
      next(error);
    }
  },

  // POST handler
  async postMethod(req, res, next) {
    try {
      const { bodyData } = req.body;
      
      const result = await someService.create(bodyData);
      
      res.status(201).json({
        success: true,
        data: result
      });
    } catch (error) {
      next(error);
    }
  }
};
```

## Controller Responsibilities

### `authController.js`
- User registration
- User login/logout
- Password reset
- Token refresh
- Email verification

### `movieController.js`
- Get movie details
- Search movies
- Get movie recommendations
- Rate movies
- Add movies to watchlist

### `userController.js`
- Get user profile
- Update user profile
- Delete user account
- Get user preferences
- Get user watch history

### `recommendationController.js`
- Generate personalized recommendations
- Get trending movies
- Get similar movies
- Get recommendations by genre
- Get collaborative filtering results

## Error Handling

Controllers use Express error handling middleware:
- Catch all errors in try-catch blocks
- Pass errors to `next(error)` for centralized handling
- Return consistent error response format
- Log errors for debugging

## Response Format

Standard response format:
```javascript
// Success response
{
  "success": true,
  "data": { ... },
  "message": "Operation completed successfully"
}

// Error response
{
  "success": false,
  "error": "Error message",
  "code": "ERROR_CODE"
}
```

## Validation

Controllers work with validation middleware:
- Input validation using express-validator
- Parameter sanitization
- Type checking and conversion
- Custom validation rules

## Testing

Each controller should have corresponding tests:
- Unit tests for individual methods
- Integration tests with routes
- Mock service dependencies
- Test error scenarios 