# Tests

This directory contains all test files for the Movie Recommendation Backend API.

## Purpose

Tests provide:
- Unit testing for individual functions
- Integration testing for API endpoints
- End-to-end testing for complete workflows
- Performance testing
- Security testing
- Test coverage reporting

## File Structure

```
tests/
├── unit/                 # Unit tests
│   ├── controllers/      # Controller unit tests
│   ├── services/         # Service unit tests
│   ├── models/           # Model unit tests
│   ├── middleware/       # Middleware unit tests
│   ├── utils/            # Utility function tests
│   └── validators/       # Validator tests
├── integration/          # Integration tests
│   ├── auth.test.js      # Authentication flow tests
│   ├── movies.test.js    # Movie API tests
│   ├── users.test.js     # User API tests
│   └── recommendations.test.js  # Recommendation tests
├── e2e/                  # End-to-end tests
│   ├── user-journey.test.js  # Complete user workflows
│   └── api-workflow.test.js  # API workflow tests
├── fixtures/             # Test data and fixtures
│   ├── users.json        # User test data
│   ├── movies.json       # Movie test data
│   └── ratings.json      # Rating test data
├── mocks/                # Mock objects and functions
│   ├── database.js       # Database mocks
│   ├── external-apis.js  # External API mocks
│   └── services.js       # Service mocks
├── utils/                # Test utilities
│   ├── test-helper.js    # Test helper functions
│   ├── test-database.js  # Test database setup
│   └── test-server.js    # Test server setup
└── coverage/             # Test coverage reports
```

## Testing Framework

The project uses:
- **Jest** - Testing framework
- **Supertest** - HTTP assertion library
- **@types/jest** - TypeScript support
- **jest-extended** - Additional matchers
- **ts-jest** - TypeScript testing

## Test Categories

### Unit Tests (`unit/`)
Test individual functions and methods in isolation.

**Coverage:**
- Controllers - Request/response handling
- Services - Business logic
- Models - Database operations
- Middleware - Request processing
- Utils - Helper functions
- Validators - Input validation

**Example Unit Test:**
```javascript
// unit/services/authService.test.js
const authService = require('../../src/services/authService');
const bcrypt = require('bcryptjs');

describe('AuthService', () => {
  describe('register', () => {
    it('should create a new user with hashed password', async () => {
      const userData = {
        email: 'test@example.com',
        password: 'password123',
        username: 'testuser'
      };

      const result = await authService.register(userData);

      expect(result).toHaveProperty('id');
      expect(result.email).toBe(userData.email);
      expect(result.password).not.toBe(userData.password);
      expect(await bcrypt.compare(userData.password, result.password)).toBe(true);
    });
  });
});
```

### Integration Tests (`integration/`)
Test API endpoints and database interactions.

**Coverage:**
- API endpoint functionality
- Database operations
- Middleware integration
- Error handling
- Response formatting

**Example Integration Test:**
```javascript
// integration/auth.test.js
const request = require('supertest');
const app = require('../../src/app');
const { setupTestDatabase, cleanupTestDatabase } = require('../utils/test-database');

describe('Auth API', () => {
  beforeAll(async () => {
    await setupTestDatabase();
  });

  afterAll(async () => {
    await cleanupTestDatabase();
  });

  describe('POST /api/auth/register', () => {
    it('should register a new user', async () => {
      const userData = {
        email: 'test@example.com',
        password: 'password123',
        username: 'testuser'
      };

      const response = await request(app)
        .post('/api/auth/register')
        .send(userData)
        .expect(201);

      expect(response.body).toHaveProperty('success', true);
      expect(response.body.data).toHaveProperty('id');
      expect(response.body.data).toHaveProperty('email', userData.email);
    });
  });
});
```

### End-to-End Tests (`e2e/`)
Test complete user workflows and scenarios.

**Coverage:**
- Complete user registration and login
- Movie browsing and rating
- Recommendation generation
- Profile management
- Error scenarios

**Example E2E Test:**
```javascript
// e2e/user-journey.test.js
const request = require('supertest');
const app = require('../../src/app');

describe('User Journey', () => {
  let authToken;
  let userId;

  it('should complete full user journey', async () => {
    // 1. Register user
    const registerResponse = await request(app)
      .post('/api/auth/register')
      .send({
        email: 'journey@example.com',
        password: 'password123',
        username: 'journeyuser'
      });

    expect(registerResponse.status).toBe(201);
    userId = registerResponse.body.data.id;

    // 2. Login user
    const loginResponse = await request(app)
      .post('/api/auth/login')
      .send({
        email: 'journey@example.com',
        password: 'password123'
      });

    expect(loginResponse.status).toBe(200);
    authToken = loginResponse.body.data.token;

    // 3. Browse movies
    const moviesResponse = await request(app)
      .get('/api/movies')
      .set('Authorization', `Bearer ${authToken}`);

    expect(moviesResponse.status).toBe(200);
    expect(moviesResponse.body.data).toHaveProperty('movies');

    // 4. Rate a movie
    const movieId = moviesResponse.body.data.movies[0].id;
    const ratingResponse = await request(app)
      .post(`/api/movies/${movieId}/rate`)
      .set('Authorization', `Bearer ${authToken}`)
      .send({ rating: 8 });

    expect(ratingResponse.status).toBe(201);

    // 5. Get recommendations
    const recommendationsResponse = await request(app)
      .get('/api/recommendations')
      .set('Authorization', `Bearer ${authToken}`);

    expect(recommendationsResponse.status).toBe(200);
    expect(recommendationsResponse.body.data).toHaveProperty('recommendations');
  });
});
```

## Test Utilities

### Test Database (`utils/test-database.js`)
Manages test database setup and cleanup.

**Functions:**
- `setupTestDatabase()` - Create test database
- `cleanupTestDatabase()` - Clean up test data
- `seedTestData()` - Insert test fixtures
- `clearTestData()` - Clear all test data

### Test Server (`utils/test-server.js`)
Creates test server instances.

**Functions:**
- `createTestServer()` - Create Express app for testing
- `setupTestMiddleware()` - Configure test middleware
- `mockExternalServices()` - Mock external dependencies

### Test Helper (`utils/test-helper.js`)
Common test helper functions.

**Functions:**
- `generateTestUser()` - Create test user data
- `generateTestMovie()` - Create test movie data
- `createAuthToken()` - Generate test JWT tokens
- `mockRequest()` - Create mock request objects
- `mockResponse()` - Create mock response objects

## Test Fixtures

### User Fixtures (`fixtures/users.json`)
Test user data for different scenarios.

```json
{
  "validUser": {
    "email": "test@example.com",
    "password": "password123",
    "username": "testuser"
  },
  "invalidUser": {
    "email": "invalid-email",
    "password": "123",
    "username": ""
  }
}
```

### Movie Fixtures (`fixtures/movies.json`)
Test movie data for different test cases.

```json
{
  "validMovie": {
    "title": "Test Movie",
    "overview": "A test movie for testing",
    "release_date": "2024-01-01",
    "vote_average": 8.5
  },
  "invalidMovie": {
    "title": "",
    "overview": "x".repeat(1001),
    "release_date": "invalid-date"
  }
}
```

## Mock Objects

### Database Mocks (`mocks/database.js`)
Mock database operations for unit testing.

```javascript
const mockDatabase = {
  query: jest.fn(),
  getClient: jest.fn(),
  pool: {
    end: jest.fn()
  }
};

module.exports = mockDatabase;
```

### External API Mocks (`mocks/external-apis.js`)
Mock external API calls.

```javascript
const mockTMDB = {
  searchMovies: jest.fn(),
  getMovieDetails: jest.fn(),
  getTrendingMovies: jest.fn()
};

module.exports = mockTMDB;
```

## Test Configuration

### Jest Configuration
```javascript
// jest.config.js
module.exports = {
  testEnvironment: 'node',
  roots: ['<rootDir>/tests'],
  testMatch: ['**/*.test.js'],
  collectCoverageFrom: [
    'src/**/*.js',
    '!src/index.js'
  ],
  coverageDirectory: 'tests/coverage',
  setupFilesAfterEnv: ['<rootDir>/tests/utils/test-setup.js']
};
```

## Running Tests

```bash
# Run all tests
npm test

# Run unit tests only
npm run test:unit

# Run integration tests only
npm run test:integration

# Run e2e tests only
npm run test:e2e

# Run tests with coverage
npm run test:coverage

# Run tests in watch mode
npm run test:watch
```

## Test Scripts

```json
{
  "scripts": {
    "test": "jest",
    "test:unit": "jest tests/unit",
    "test:integration": "jest tests/integration",
    "test:e2e": "jest tests/e2e",
    "test:coverage": "jest --coverage",
    "test:watch": "jest --watch",
    "test:ci": "jest --ci --coverage --watchAll=false"
  }
}
```

## Best Practices

- Write tests before implementing features (TDD)
- Keep tests focused and isolated
- Use descriptive test names
- Mock external dependencies
- Test both success and error scenarios
- Maintain test data consistency
- Use test factories for data generation
- Implement proper cleanup in tests
- Monitor test coverage
- Run tests in CI/CD pipeline 