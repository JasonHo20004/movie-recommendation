# Backend Source Code

This directory contains the main source code for the Movie Recommendation Backend API.

## Directory Structure

```
src/
├── config/          # Configuration files (database, environment, etc.)
├── controllers/     # Request handlers and business logic
├── middleware/      # Custom Express middleware
├── models/          # Data models and database schemas
├── routes/          # API route definitions
├── services/        # Business logic and external API integrations
├── utils/           # Utility functions and helpers
├── validators/      # Input validation schemas
└── index.js         # Main application entry point
```

## Key Files

- `index.js` - Main server file that initializes Express app, middleware, and routes
- `config/` - Contains database configuration and environment setup
- `routes/` - API endpoint definitions organized by resource
- `controllers/` - Request handlers that process incoming requests
- `services/` - Business logic layer for recommendation algorithms and external APIs
- `middleware/` - Custom middleware for authentication, validation, etc.

## Tech Stack

- **Express.js** - Web framework
- **PostgreSQL** - Primary database
- **Sequelize** - ORM for database operations
- **JWT** - Authentication and authorization
- **bcryptjs** - Password hashing
- **express-validator** - Input validation
- **cors** - Cross-origin resource sharing
- **morgan** - HTTP request logging
- **dotenv** - Environment variable management

## Getting Started

1. Install dependencies: `npm install`
2. Set up environment variables in `.env`
3. Initialize database: `npm run db:setup`
4. Start development server: `npm run dev`
5. Start production server: `npm start`

## API Documentation

The API follows RESTful conventions and is organized by resource:
- `/api/movies` - Movie-related endpoints
- `/api/users` - User management endpoints
- `/api/auth` - Authentication endpoints
- `/api/recommendations` - Recommendation endpoints 