# Documentation

This directory contains comprehensive documentation for the Movie Recommendation Backend API.

## Purpose

Documentation provides:
- API endpoint documentation
- Database schema documentation
- Setup and installation guides
- Development guidelines
- Deployment instructions
- Troubleshooting guides

## File Structure

```
docs/
├── api/                  # API documentation
│   ├── endpoints.md      # Complete API endpoint reference
│   ├── authentication.md # Authentication documentation
│   ├── errors.md         # Error codes and messages
│   ├── examples.md       # API usage examples
│   └── postman/          # Postman collection
│       ├── collection.json
│       └── environment.json
├── database/             # Database documentation
│   ├── schema.md         # Database schema reference
│   ├── migrations.md     # Migration documentation
│   ├── relationships.md  # Table relationships
│   └── indexes.md        # Database indexes
├── setup/                # Setup documentation
│   ├── installation.md   # Installation guide
│   ├── configuration.md  # Configuration guide
│   ├── environment.md    # Environment variables
│   └── docker.md         # Docker setup
├── development/          # Development guides
│   ├── getting-started.md # Development setup
│   ├── coding-standards.md # Code standards
│   ├── testing.md        # Testing guidelines
│   └── deployment.md     # Deployment guide
├── architecture/         # Architecture documentation
│   ├── overview.md       # System overview
│   ├── components.md     # Component architecture
│   ├── data-flow.md      # Data flow diagrams
│   └── security.md       # Security architecture
└── troubleshooting/      # Troubleshooting guides
    ├── common-issues.md  # Common problems
    ├── debugging.md      # Debugging guide
    └── performance.md    # Performance optimization
```

## API Documentation

### Endpoints Reference (`api/endpoints.md`)
Complete reference of all API endpoints.

**Sections:**
- Authentication endpoints
- User management endpoints
- Movie endpoints
- Recommendation endpoints
- Genre endpoints

**Format:**
```markdown
## POST /api/auth/register

Register a new user account.

### Request Body
```json
{
  "email": "user@example.com",
  "password": "password123",
  "username": "movie_lover"
}
```

### Response
```json
{
  "success": true,
  "data": {
    "id": 1,
    "email": "user@example.com",
    "username": "movie_lover",
    "created_at": "2024-01-01T00:00:00Z"
  }
}
```

### Error Responses
- `400` - Validation error
- `409` - Email already exists
```

### Authentication Documentation (`api/authentication.md`)
JWT-based authentication system documentation.

**Topics:**
- Token generation and validation
- Authentication flow
- Token refresh mechanism
- Password reset process
- Email verification

### Error Codes (`api/errors.md`)
Complete list of error codes and messages.

**Error Categories:**
- Validation errors (400)
- Authentication errors (401)
- Authorization errors (403)
- Not found errors (404)
- Server errors (500)

## Database Documentation

### Schema Reference (`database/schema.md`)
Complete database schema documentation.

**Tables:**
- Users
- Movies
- Ratings
- Watchlists
- Genres
- UserGenres
- MovieGenres

**Example:**
```markdown
## Users Table

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | INTEGER | PRIMARY KEY, AUTO_INCREMENT | Unique user identifier |
| email | VARCHAR(255) | UNIQUE, NOT NULL | User email address |
| password | VARCHAR(255) | NOT NULL | Hashed password |
| username | VARCHAR(100) | UNIQUE, NOT NULL | Display username |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Account creation date |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE | Last update date |
```

### Migration Documentation (`database/migrations.md`)
Database migration history and procedures.

**Migration Files:**
- 001_create_users.js
- 002_create_movies.js
- 003_create_ratings.js
- 004_add_indexes.js

## Setup Documentation

### Installation Guide (`setup/installation.md`)
Step-by-step installation instructions.

**Prerequisites:**
- Node.js 18+
- PostgreSQL 14+
- Redis (optional)

**Installation Steps:**
1. Clone the repository
2. Install dependencies
3. Set up environment variables
4. Initialize database
5. Start the server

### Configuration Guide (`setup/configuration.md`)
Configuration options and settings.

**Configuration Files:**
- Environment variables
- Database configuration
- JWT configuration
- CORS settings
- Logging configuration

### Environment Variables (`setup/environment.md`)
Complete list of environment variables.

**Required Variables:**
```bash
# Database
DATABASE_URL=postgresql://user:password@localhost:5432/movie_recommendation

# JWT
JWT_SECRET=your-secret-key
JWT_EXPIRES_IN=24h

# Server
PORT=3001
NODE_ENV=development

# External APIs
TMDB_API_KEY=your-tmdb-api-key
```

## Development Documentation

### Getting Started (`development/getting-started.md`)
Development environment setup.

**Development Setup:**
1. Install development dependencies
2. Set up local database
3. Configure environment
4. Run development server
5. Run tests

### Coding Standards (`development/coding-standards.md`)
Code style and conventions.

**Standards:**
- ESLint configuration
- Prettier formatting
- Naming conventions
- File organization
- Comment standards

### Testing Guidelines (`development/testing.md`)
Testing practices and procedures.

**Testing Types:**
- Unit tests
- Integration tests
- End-to-end tests
- Performance tests

## Architecture Documentation

### System Overview (`architecture/overview.md`)
High-level system architecture.

**Components:**
- API Layer (Express.js)
- Business Logic Layer (Services)
- Data Access Layer (Models)
- External Integrations (TMDB API)

### Component Architecture (`architecture/components.md`)
Detailed component descriptions.

**Components:**
- Authentication Service
- Movie Service
- Recommendation Service
- User Service
- Cache Service

### Data Flow (`architecture/data-flow.md`)
Data flow diagrams and descriptions.

**Flows:**
- User registration flow
- Movie recommendation flow
- Rating submission flow
- Authentication flow

## Troubleshooting

### Common Issues (`troubleshooting/common-issues.md`)
Solutions to common problems.

**Issues:**
- Database connection errors
- JWT token issues
- CORS errors
- Rate limiting problems
- Performance issues

### Debugging Guide (`troubleshooting/debugging.md`)
Debugging techniques and tools.

**Debugging Tools:**
- Logging configuration
- Error tracking
- Performance monitoring
- Database query analysis

## API Examples

### Postman Collection (`api/postman/`)
Ready-to-use Postman collection.

**Collection Includes:**
- Authentication requests
- User management requests
- Movie requests
- Recommendation requests
- Environment variables

### Usage Examples (`api/examples.md`)
Code examples for different languages.

**Examples:**
- JavaScript/Node.js
- Python
- cURL
- PHP
- Java

## Documentation Maintenance

### Updating Documentation
- Keep documentation in sync with code changes
- Update API documentation when endpoints change
- Maintain accurate database schema documentation
- Update setup guides for new dependencies

### Documentation Standards
- Use clear and concise language
- Include code examples
- Provide step-by-step instructions
- Use consistent formatting
- Include troubleshooting sections

## Tools and Resources

### Documentation Tools
- **Markdown** - Documentation format
- **Postman** - API testing and documentation
- **Swagger/OpenAPI** - API specification
- **Mermaid** - Diagram generation

### External Resources
- Express.js documentation
- PostgreSQL documentation
- JWT documentation
- TMDB API documentation 