# Movie Recommendation Backend

A robust Node.js backend API for a movie recommendation system built with Express.js, PostgreSQL, and JWT authentication.

## 🚀 Features

- **User Authentication** - JWT-based authentication with bcrypt password hashing
- **Movie Management** - CRUD operations for movies with TMDB integration
- **Recommendation Engine** - Collaborative filtering and content-based recommendations
- **User Profiles** - User preferences, watchlists, and rating history
- **RESTful API** - Well-structured REST endpoints with proper error handling
- **Database Integration** - PostgreSQL with Sequelize ORM
- **Input Validation** - Comprehensive validation using express-validator
- **Rate Limiting** - API rate limiting and abuse prevention
- **Caching** - Redis-based caching for improved performance
- **Testing** - Comprehensive test suite with Jest
- **Documentation** - Complete API documentation and guides

## 🏗️ Architecture

```
backend/
├── src/                   # Source code
│   ├── config/           # Configuration files
│   ├── controllers/      # Request handlers
│   ├── middleware/       # Express middleware
│   ├── models/           # Database models
│   ├── routes/           # API routes
│   ├── services/         # Business logic
│   ├── utils/            # Utility functions
│   ├── validators/       # Input validation
│   └── index.js          # Application entry point
├── tests/                # Test files
├── docs/                 # Documentation
├── scripts/              # Utility scripts
└── package.json          # Dependencies and scripts
```

## 🛠️ Tech Stack

- **Runtime**: Node.js 18+
- **Framework**: Express.js
- **Database**: PostgreSQL 14+
- **ORM**: Sequelize
- **Authentication**: JWT + bcryptjs
- **Validation**: express-validator
- **Testing**: Jest + Supertest
- **Caching**: Redis (optional)
- **Logging**: Morgan + Winston
- **Documentation**: OpenAPI/Swagger

## 📋 Prerequisites

- Node.js 18 or higher
- PostgreSQL 14 or higher
- Redis (optional, for caching)
- TMDB API key (for movie data)

## 🚀 Quick Start

### 1. Clone and Install

```bash
git clone <repository-url>
cd movie-recommendation/backend
npm install
```

### 2. Environment Setup

Create a `.env` file in the backend directory:

```bash
# Database
DATABASE_URL=postgresql://username:password@localhost:5432/movie_recommendation

# JWT
JWT_SECRET=your-super-secret-jwt-key
JWT_EXPIRES_IN=24h

# Server
PORT=3001
NODE_ENV=development

# External APIs
TMDB_API_KEY=your-tmdb-api-key

# Optional: Redis
REDIS_URL=redis://localhost:6379
```

### 3. Database Setup

```bash
# Create database
createdb movie_recommendation

# Run migrations
npm run migrate

# Seed with test data
npm run seed
```

### 4. Start Development Server

```bash
npm run dev
```

The API will be available at `http://localhost:3001`

## 📚 API Documentation

### Base URL
```
http://localhost:3001/api
```

### Authentication Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/auth/register` | Register new user |
| POST | `/auth/login` | User login |
| POST | `/auth/logout` | User logout |
| POST | `/auth/refresh` | Refresh token |
| POST | `/auth/forgot-password` | Request password reset |
| POST | `/auth/reset-password` | Reset password |

### Movie Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/movies` | Get all movies |
| GET | `/movies/:id` | Get movie by ID |
| GET | `/movies/search` | Search movies |
| GET | `/movies/trending` | Get trending movies |
| POST | `/movies/:id/rate` | Rate a movie |

### User Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/users/profile` | Get user profile |
| PUT | `/users/profile` | Update user profile |
| GET | `/users/watchlist` | Get user watchlist |
| POST | `/users/watchlist` | Add movie to watchlist |

### Recommendation Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/recommendations` | Get personalized recommendations |
| GET | `/recommendations/trending` | Get trending recommendations |
| GET | `/recommendations/genre/:id` | Get genre-based recommendations |

## 🧪 Testing

```bash
# Run all tests
npm test

# Run unit tests only
npm run test:unit

# Run integration tests only
npm run test:integration

# Run tests with coverage
npm run test:coverage

# Run tests in watch mode
npm run test:watch
```

## 📦 Available Scripts

```bash
# Development
npm run dev              # Start development server
npm run setup            # Setup development environment
npm run seed             # Seed database with test data

# Database
npm run migrate          # Run database migrations
npm run migrate:undo     # Undo last migration
npm run db:reset         # Reset database

# Testing
npm test                 # Run all tests
npm run test:unit        # Run unit tests
npm run test:integration # Run integration tests
npm run test:coverage    # Run tests with coverage

# Production
npm start                # Start production server
npm run build            # Build for production
npm run health-check     # Health check

# Maintenance
npm run backup           # Database backup
npm run cleanup          # Clean up logs
npm run optimize         # Database optimization
```

## 🔧 Configuration

### Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `DATABASE_URL` | PostgreSQL connection string | Required |
| `JWT_SECRET` | JWT signing secret | Required |
| `JWT_EXPIRES_IN` | JWT token expiration | `24h` |
| `PORT` | Server port | `3001` |
| `NODE_ENV` | Environment | `development` |
| `TMDB_API_KEY` | TMDB API key | Required |
| `REDIS_URL` | Redis connection string | Optional |
| `CORS_ORIGIN` | Allowed CORS origins | `*` |
| `LOG_LEVEL` | Logging level | `info` |

### Database Configuration

The application uses PostgreSQL with the following main tables:

- **users** - User accounts and profiles
- **movies** - Movie information and metadata
- **ratings** - User movie ratings
- **watchlists** - User watchlists
- **genres** - Movie genres
- **user_genres** - User genre preferences
- **movie_genres** - Movie genre associations

## 🏛️ Project Structure

### `/src` - Source Code

- **`config/`** - Database and environment configuration
- **`controllers/`** - Request handlers and business logic
- **`middleware/`** - Custom Express middleware
- **`models/`** - Database models and schemas
- **`routes/`** - API route definitions
- **`services/`** - Business logic and external integrations
- **`utils/`** - Utility functions and helpers
- **`validators/`** - Input validation schemas

### `/tests` - Testing

- **`unit/`** - Unit tests for individual functions
- **`integration/`** - Integration tests for API endpoints
- **`e2e/`** - End-to-end tests for complete workflows
- **`fixtures/`** - Test data and fixtures
- **`mocks/`** - Mock objects and functions

### `/docs` - Documentation

- **`api/`** - API documentation and examples
- **`database/`** - Database schema and migration docs
- **`setup/`** - Installation and configuration guides
- **`development/`** - Development guidelines

### `/scripts` - Utility Scripts

- **`development/`** - Development automation scripts
- **`database/`** - Database management scripts
- **`deployment/`** - Deployment and build scripts
- **`maintenance/`** - Maintenance and cleanup scripts

## 🔒 Security Features

- JWT-based authentication
- Password hashing with bcrypt
- Input validation and sanitization
- CORS configuration
- Rate limiting
- SQL injection prevention
- XSS protection
- Environment variable management

## 📊 Performance Features

- Database connection pooling
- Query optimization
- Caching with Redis
- Response compression
- Static file serving
- Error monitoring
- Performance logging

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow the existing code style
- Write tests for new features
- Update documentation
- Use conventional commit messages
- Ensure all tests pass

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](../LICENSE) file for details.

## 🆘 Support

For support and questions:

- Check the [documentation](./docs/)
- Review [common issues](./docs/troubleshooting/common-issues.md)
- Open an issue on GitHub
- Contact the development team

## 🔄 Version History

- **v1.0.0** - Initial release with basic CRUD operations
- **v1.1.0** - Added recommendation engine
- **v1.2.0** - Enhanced authentication and security
- **v1.3.0** - Performance optimizations and caching

## 🙏 Acknowledgments

- [Express.js](https://expressjs.com/) - Web framework
- [Sequelize](https://sequelize.org/) - ORM
- [JWT](https://jwt.io/) - Authentication
- [TMDB](https://www.themoviedb.org/) - Movie data API
- [PostgreSQL](https://www.postgresql.org/) - Database 