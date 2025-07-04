# Middleware

This directory contains custom Express middleware functions that process requests before they reach route handlers.

## Purpose

Middleware functions provide:
- Request preprocessing and validation
- Authentication and authorization
- Logging and monitoring
- Error handling
- Response formatting
- Security features

## File Structure

```
middleware/
├── auth.js              # Authentication middleware
├── validation.js        # Input validation middleware
├── errorHandler.js      # Error handling middleware
├── rateLimiter.js       # Rate limiting middleware
├── cors.js              # CORS configuration
├── logger.js            # Request logging middleware
└── index.js             # Middleware exports
```

## Middleware Pattern

Each middleware follows the standard Express pattern:

```javascript
// Example middleware structure
const middlewareName = (req, res, next) => {
  try {
    // Process request
    // Modify req object if needed
    
    // Call next() to continue to next middleware/route
    next();
  } catch (error) {
    // Handle errors
    next(error);
  }
};

// Middleware with options
const configurableMiddleware = (options = {}) => {
  return (req, res, next) => {
    // Use options to configure behavior
    next();
  };
};
```

## Middleware Functions

### `auth.js`
JWT-based authentication middleware.

**Features:**
- Verify JWT tokens from Authorization header
- Extract user information from token
- Add user data to request object
- Handle token expiration
- Support for role-based access control

**Usage:**
```javascript
// Protect routes
router.get('/protected', auth.requireAuth, controller.method);

// Optional authentication
router.get('/public', auth.optionalAuth, controller.method);
```

### `validation.js`
Input validation using express-validator.

**Features:**
- Request body validation
- Query parameter validation
- URL parameter validation
- Custom validation rules
- Sanitization of inputs
- Consistent error responses

**Usage:**
```javascript
const { validateMovie } = require('../middleware/validation');

router.post('/movies', validateMovie, controller.createMovie);
```

### `errorHandler.js`
Centralized error handling middleware.

**Features:**
- Catch and format all errors
- Log errors for debugging
- Return appropriate HTTP status codes
- Hide sensitive information in production
- Handle different error types

### `rateLimiter.js`
Rate limiting to prevent abuse.

**Features:**
- Limit requests per IP address
- Configurable time windows
- Different limits for different endpoints
- Rate limit headers in responses
- Blocklist for abusive IPs

### `cors.js`
Cross-Origin Resource Sharing configuration.

**Features:**
- Configure allowed origins
- Handle preflight requests
- Set appropriate CORS headers
- Environment-specific configuration

### `logger.js`
Request logging and monitoring.

**Features:**
- Log all incoming requests
- Track response times
- Log errors and exceptions
- Performance monitoring
- Request/response correlation

## Middleware Order

Middleware is applied in this order:
1. CORS
2. Body parsing
3. Request logging
4. Rate limiting
5. Authentication (where required)
6. Validation
7. Route handlers
8. Error handling

## Custom Middleware Examples

### Request ID Middleware
```javascript
const addRequestId = (req, res, next) => {
  req.id = uuid.v4();
  res.setHeader('X-Request-ID', req.id);
  next();
};
```

### Response Time Middleware
```javascript
const responseTime = (req, res, next) => {
  const start = Date.now();
  res.on('finish', () => {
    const duration = Date.now() - start;
    console.log(`${req.method} ${req.path} - ${duration}ms`);
  });
  next();
};
```

## Testing Middleware

Each middleware should have tests:
- Unit tests for individual functions
- Integration tests with Express app
- Test error scenarios
- Test edge cases
- Mock dependencies

## Security Considerations

- Always validate and sanitize inputs
- Use HTTPS in production
- Implement proper authentication
- Rate limit to prevent abuse
- Log security events
- Handle sensitive data carefully 