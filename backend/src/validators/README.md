# Validators

This directory contains input validation schemas and rules using express-validator for request validation.

## Purpose

Validators provide:
- Request data validation
- Input sanitization
- Custom validation rules
- Error message formatting
- Validation middleware
- Type checking and conversion

## File Structure

```
validators/
├── authValidators.js     # Authentication validation
├── movieValidators.js    # Movie data validation
├── userValidators.js     # User data validation
├── ratingValidators.js   # Rating validation
├── commonValidators.js   # Common validation rules
├── customValidators.js   # Custom validation functions
└── index.js              # Validator exports
```

## Validator Pattern

Each validator follows a consistent pattern:

```javascript
// Example validator structure
const { body, param, query, validationResult } = require('express-validator');
const { customValidators } = require('./customValidators');

const validateCreateMovie = [
  // Body validation
  body('title')
    .trim()
    .notEmpty()
    .withMessage('Title is required')
    .isLength({ min: 1, max: 255 })
    .withMessage('Title must be between 1 and 255 characters'),
  
  body('overview')
    .optional()
    .trim()
    .isLength({ max: 1000 })
    .withMessage('Overview must be less than 1000 characters'),
  
  body('release_date')
    .optional()
    .isISO8601()
    .withMessage('Release date must be a valid date'),
  
  // Custom validation
  body('rating')
    .optional()
    .custom(customValidators.isValidRating)
    .withMessage('Rating must be between 1 and 10'),
  
  // Handle validation results
  (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        success: false,
        errors: errors.array()
      });
    }
    next();
  }
];

module.exports = {
  validateCreateMovie
};
```

## Validator Categories

### `authValidators.js`
Authentication and user management validation.

**Validators:**
- `validateRegister` - User registration validation
- `validateLogin` - User login validation
- `validatePasswordReset` - Password reset validation
- `validateEmailVerification` - Email verification validation
- `validateChangePassword` - Password change validation

**Validation Rules:**
- Email format validation
- Password strength requirements
- Username format validation
- Required field validation
- Token format validation

### `movieValidators.js`
Movie data validation.

**Validators:**
- `validateCreateMovie` - Create movie validation
- `validateUpdateMovie` - Update movie validation
- `validateMovieSearch` - Movie search validation
- `validateMovieRating` - Movie rating validation
- `validateMovieFilters` - Movie filter validation

**Validation Rules:**
- Title length and format
- Overview length limits
- Release date format
- Rating range validation
- Genre validation
- Search query validation

### `userValidators.js`
User profile and preferences validation.

**Validators:**
- `validateUserProfile` - User profile validation
- `validateUserPreferences` - User preferences validation
- `validateWatchlist` - Watchlist validation
- `validateUserUpdate` - User update validation

**Validation Rules:**
- Profile field validation
- Preference format validation
- Watchlist item validation
- Avatar upload validation

### `ratingValidators.js`
Rating and review validation.

**Validators:**
- `validateRating` - Rating submission validation
- `validateReview` - Review text validation
- `validateRatingUpdate` - Rating update validation

**Validation Rules:**
- Rating value range (1-10)
- Review text length
- Rating date validation
- User permission validation

### `commonValidators.js`
Common validation rules used across multiple validators.

**Validators:**
- `validatePagination` - Pagination parameters
- `validateId` - ID parameter validation
- `validateEmail` - Email format validation
- `validatePassword` - Password strength validation
- `validateDate` - Date format validation

### `customValidators.js`
Custom validation functions for complex validation logic.

**Functions:**
- `isValidRating` - Rating value validation
- `isValidGenre` - Genre validation
- `isValidImageUrl` - Image URL validation
- `isValidReleaseDate` - Release date validation
- `isValidUsername` - Username format validation
- `isValidMovieId` - Movie ID format validation

## Validation Middleware

Validators can be used as middleware:

```javascript
// Apply validation to route
router.post('/movies', 
  movieValidators.validateCreateMovie,
  movieController.createMovie
);

// Apply multiple validators
router.put('/users/:id', 
  userValidators.validateUserUpdate,
  authValidators.validateAuthentication,
  userController.updateUser
);
```

## Error Handling

Validation errors are handled consistently:

```javascript
// Error response format
{
  "success": false,
  "errors": [
    {
      "field": "email",
      "message": "Email is required",
      "value": ""
    },
    {
      "field": "password",
      "message": "Password must be at least 8 characters",
      "value": "123"
    }
  ]
}
```

## Custom Validation Examples

```javascript
// Custom validator function
const isValidRating = (value) => {
  const rating = parseInt(value);
  if (isNaN(rating) || rating < 1 || rating > 10) {
    throw new Error('Rating must be a number between 1 and 10');
  }
  return true;
};

// Custom validator with async validation
const isUniqueEmail = async (value) => {
  const user = await User.findOne({ where: { email: value } });
  if (user) {
    throw new Error('Email already exists');
  }
  return true;
};

// Custom validator with database check
const movieExists = async (value) => {
  const movie = await Movie.findByPk(value);
  if (!movie) {
    throw new Error('Movie not found');
  }
  return true;
};
```

## Sanitization

Validators include data sanitization:

```javascript
// Sanitize input data
body('title')
  .trim()                    // Remove whitespace
  .escape()                  // Escape HTML
  .toLowerCase()             // Convert to lowercase

body('email')
  .normalizeEmail()          // Normalize email format
  .toLowerCase()             // Convert to lowercase

body('description')
  .trim()
  .escape()
  .blacklist('<>')           // Remove specific characters
```

## Testing Validators

Each validator should have tests:
- Unit tests for validation rules
- Integration tests with routes
- Test error scenarios
- Test edge cases
- Test custom validators
- Test sanitization

## Best Practices

- Use descriptive error messages
- Validate at the earliest point
- Sanitize all user inputs
- Use appropriate validation types
- Keep validators focused and reusable
- Document validation rules
- Handle async validation properly
- Use consistent error formats 