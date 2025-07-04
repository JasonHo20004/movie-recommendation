# Utils

This directory contains utility functions, helpers, and common tools used throughout the application.

## Purpose

Utils provide:
- Reusable helper functions
- Data transformation utilities
- Validation helpers
- Date and time utilities
- String manipulation functions
- Common constants and configurations
- External API integrations

## File Structure

```
utils/
├── constants.js         # Application constants
├── helpers.js           # General helper functions
├── validation.js        # Validation utilities
├── dateUtils.js         # Date and time utilities
├── stringUtils.js       # String manipulation
├── mathUtils.js         # Mathematical operations
├── apiUtils.js          # API integration helpers
├── logger.js            # Logging utility
├── errors.js            # Custom error classes
└── index.js             # Utility exports
```

## Utility Categories

### `constants.js`
Application-wide constants and configurations.

**Contents:**
- API endpoints
- Database table names
- HTTP status codes
- Error messages
- Configuration values
- Environment-specific constants

```javascript
// Example constants
const API_ENDPOINTS = {
  TMDB_BASE_URL: 'https://api.themoviedb.org/3',
  TMDB_IMAGE_BASE: 'https://image.tmdb.org/t/p'
};

const HTTP_STATUS = {
  OK: 200,
  CREATED: 201,
  BAD_REQUEST: 400,
  UNAUTHORIZED: 401,
  NOT_FOUND: 404,
  INTERNAL_SERVER: 500
};

const ERROR_MESSAGES = {
  USER_NOT_FOUND: 'User not found',
  INVALID_CREDENTIALS: 'Invalid credentials',
  MOVIE_NOT_FOUND: 'Movie not found'
};
```

### `helpers.js`
General-purpose helper functions.

**Functions:**
- `generateId()` - Generate unique identifiers
- `formatResponse(data, message)` - Format API responses
- `paginateResults(results, page, limit)` - Pagination helper
- `filterObject(obj, allowedKeys)` - Filter object properties
- `deepClone(obj)` - Deep object cloning
- `isEmpty(value)` - Check if value is empty
- `isValidEmail(email)` - Email validation
- `generateSlug(text)` - Generate URL-friendly slugs

### `validation.js`
Validation utility functions.

**Functions:**
- `validateEmail(email)` - Email format validation
- `validatePassword(password)` - Password strength validation
- `validateMovieData(data)` - Movie data validation
- `validateUserData(data)` - User data validation
- `sanitizeInput(input)` - Input sanitization
- `validatePagination(page, limit)` - Pagination validation
- `validateRating(rating)` - Rating value validation

### `dateUtils.js`
Date and time manipulation utilities.

**Functions:**
- `formatDate(date, format)` - Date formatting
- `parseDate(dateString)` - Date parsing
- `addDays(date, days)` - Add days to date
- `subtractDays(date, days)` - Subtract days from date
- `isToday(date)` - Check if date is today
- `isThisWeek(date)` - Check if date is this week
- `getDateRange(start, end)` - Get date range
- `formatRelativeTime(date)` - Relative time formatting

### `stringUtils.js`
String manipulation and processing.

**Functions:**
- `capitalize(str)` - Capitalize first letter
- `camelCase(str)` - Convert to camelCase
- `snakeCase(str)` - Convert to snake_case
- `kebabCase(str)` - Convert to kebab-case
- `truncate(str, length)` - Truncate string
- `slugify(str)` - Create URL-friendly slug
- `escapeHtml(str)` - Escape HTML characters
- `normalizeString(str)` - Normalize string

### `mathUtils.js`
Mathematical operations and calculations.

**Functions:**
- `calculateAverage(numbers)` - Calculate average
- `calculatePercentage(value, total)` - Calculate percentage
- `roundToDecimal(number, decimals)` - Round to decimal places
- `clamp(value, min, max)` - Clamp value between min and max
- `calculateSimilarity(vector1, vector2)` - Calculate similarity
- `normalizeScore(score, min, max)` - Normalize score
- `calculateWeightedAverage(values, weights)` - Weighted average

### `apiUtils.js`
External API integration helpers.

**Functions:**
- `makeApiRequest(url, options)` - Generic API request
- `handleApiError(error)` - API error handling
- `retryRequest(fn, maxRetries)` - Request retry logic
- `rateLimitRequest(fn, delay)` - Rate limiting
- `cacheApiResponse(key, data, ttl)` - API response caching
- `transformApiResponse(data)` - Response transformation

### `logger.js`
Logging utility with different levels.

**Features:**
- Multiple log levels (debug, info, warn, error)
- Structured logging
- Log rotation
- Environment-specific configuration
- Request correlation
- Performance monitoring

```javascript
// Example logger usage
const logger = require('./utils/logger');

logger.info('User logged in', { userId: 123 });
logger.error('Database connection failed', { error: err.message });
logger.debug('Processing request', { requestId: req.id });
```

### `errors.js`
Custom error classes for better error handling.

**Error Classes:**
- `AppError` - Base application error
- `ValidationError` - Validation errors
- `NotFoundError` - Resource not found
- `UnauthorizedError` - Authentication errors
- `ForbiddenError` - Authorization errors
- `BadRequestError` - Bad request errors
- `InternalServerError` - Server errors

```javascript
// Example custom error
class ValidationError extends AppError {
  constructor(message, field) {
    super(message, 400);
    this.name = 'ValidationError';
    this.field = field;
  }
}

// Usage
throw new ValidationError('Email is required', 'email');
```

## Usage Examples

```javascript
const {
  helpers,
  validation,
  dateUtils,
  constants,
  logger
} = require('./utils');

// Generate unique ID
const id = helpers.generateId();

// Validate email
if (!validation.validateEmail(email)) {
  throw new Error('Invalid email format');
}

// Format date
const formattedDate = dateUtils.formatDate(new Date(), 'YYYY-MM-DD');

// Log information
logger.info('Processing request', { requestId: id });

// Use constants
if (statusCode === constants.HTTP_STATUS.NOT_FOUND) {
  // Handle not found
}
```

## Testing Utils

Each utility should have tests:
- Unit tests for individual functions
- Edge case testing
- Error scenario testing
- Performance testing
- Integration testing

## Performance Considerations

- Cache frequently used calculations
- Use efficient algorithms
- Minimize memory allocations
- Optimize string operations
- Use appropriate data structures
- Profile utility functions

## Best Practices

- Keep functions pure when possible
- Use descriptive function names
- Add JSDoc documentation
- Handle edge cases
- Provide default values
- Use TypeScript for type safety
- Follow single responsibility principle 