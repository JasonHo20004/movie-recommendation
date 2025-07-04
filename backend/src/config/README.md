# Configuration

This directory contains all configuration files for the Movie Recommendation Backend.

## Files

### `database.js`
Database configuration and connection setup using PostgreSQL with connection pooling.

**Features:**
- PostgreSQL connection pool management
- Environment-based configuration
- Connection error handling
- Query logging and performance monitoring
- Graceful connection cleanup

**Key Functions:**
- `query(text, params)` - Execute parameterized queries
- `getClient()` - Get a client from the pool with timeout monitoring
- `pool` - Direct access to the connection pool

### `environment.js` (to be created)
Environment variable validation and configuration management.

**Purpose:**
- Validate required environment variables
- Set default values for optional variables
- Provide type-safe configuration access
- Centralize environment-specific settings

### `sequelize.js` (to be created)
Sequelize ORM configuration and model initialization.

**Features:**
- Database connection configuration
- Model auto-loading
- Migration and seeding setup
- Connection pooling with Sequelize

## Environment Variables

Required environment variables:
- `DATABASE_URL` - PostgreSQL connection string
- `JWT_SECRET` - Secret key for JWT token signing
- `NODE_ENV` - Environment (development/production/test)
- `PORT` - Server port (default: 3001)

Optional environment variables:
- `CORS_ORIGIN` - Allowed CORS origins
- `LOG_LEVEL` - Logging level (debug/info/warn/error)
- `API_RATE_LIMIT` - Rate limiting configuration

## Usage

```javascript
const { pool, query } = require('./config/database');
const config = require('./config/environment');

// Use database connection
const result = await query('SELECT * FROM movies WHERE id = $1', [movieId]);

// Access configuration
const port = config.PORT;
const jwtSecret = config.JWT_SECRET;
```

## Database Connection String Format

```
postgresql://username:password@host:port/database_name
```

Example:
```
DATABASE_URL=postgresql://movie_user:password123@localhost:5432/movie_recommendation
``` 