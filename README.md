# Movie Recommendation System

A modern full-stack movie recommendation system built with Next.js, Express, and PostgreSQL. The application provides movie browsing, search, and personalized recommendations based on user ratings.

## Features

- 🎬 Browse and search movies
- ⭐ Rate and review movies
- 🔍 Advanced movie search with pagination
- 🎯 Personalized movie recommendations
- 🔐 User authentication and authorization
- 📱 Responsive design for all devices
- 🚀 Real-time updates with React Query
- 🎨 Modern UI with Tailwind CSS and Styled Components

## Tech Stack

### Frontend
- Next.js 14 (React Framework)
- React Query for data fetching and caching
- NextAuth.js for authentication
- Styled Components & Tailwind CSS for styling
- Zod for form validation
- TypeScript for type safety

### Backend
- Express.js REST API
- PostgreSQL database
- JWT authentication
- Database connection pooling
- CORS enabled
- Morgan for logging

### Infrastructure
- Docker & Docker Compose
- PostgreSQL database
- Environment-based configuration

## Project Structure

```
movie-recommendation/
├── frontend/           # Next.js frontend application
│   ├── app/           # Next.js app directory
│   ├── components/    # React components
│   ├── styles/        # Global styles
│   ├── utils/         # Utility functions
│   └── services/      # API service functions
├── backend/           # Express.js backend server
│   ├── src/          # Source code
│   │   ├── routes/   # API routes
│   │   ├── models/   # Database models
│   │   └── config/   # Configuration files
│   └── db-init/      # Database initialization scripts
├── Dockerfile         # Docker configuration for the application
├── docker-compose.yml # Docker Compose configuration
└── .dockerignore     # Docker ignore rules
```

## Getting Started

### Prerequisites

- [Node.js](https://nodejs.org/) (v18 or higher)
- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [Git](https://git-scm.com/downloads)

### Quick Start with Docker (Recommended)

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd movie-recommendation
   ```

2. Create a `.env` file in the root directory:
   ```env
   # Frontend
   NEXT_PUBLIC_API_URL=http://localhost:3001
   NEXTAUTH_URL=http://localhost:3000
   NEXTAUTH_SECRET=your_nextauth_secret_here

   # Backend
   PORT=3001
   DATABASE_URL=postgresql://postgres:postgres@db:5432/movie_recommendation
   JWT_SECRET=your_jwt_secret_here
   NODE_ENV=development

   # Database
   POSTGRES_USER=postgres
   POSTGRES_PASSWORD=postgres
   POSTGRES_DB=movie_recommendation
   ```

3. Start the application:
   ```bash
   docker-compose up --build
   ```

   This will start:
   - Frontend at http://localhost:3000
   - Backend API at http://localhost:3001
   - PostgreSQL database at localhost:5432

4. To stop the application:
   ```bash
   docker-compose down
   ```

### Manual Setup (Alternative)

1. **Database Setup**
   ```bash
   # Install PostgreSQL locally
   # Create a database named 'movie_recommendation'
   createdb movie_recommendation
   ```

2. **Backend Setup**
   ```bash
   cd backend
   npm install
   # Create .env file with the same variables as above
   npm run dev
   ```

3. **Frontend Setup**
   ```bash
   cd frontend
   npm install
   # Create .env.local file with the same variables as above
   npm run dev
   ```

## Development

### Frontend Development
- Development server: `npm run dev` (http://localhost:3000)
- Build: `npm run build`
- Production: `npm start`
- Linting: `npm run lint`

### Backend Development
- Development server: `npm run dev` (http://localhost:3001)
- Build: `npm run build`
- Production: `npm start`

## Troubleshooting

### Common Issues

1. **Database Connection Issues**
   - Ensure PostgreSQL is running
   - Check database credentials in `.env`
   - Verify database exists: `createdb movie_recommendation`

2. **Port Conflicts**
   - Ensure ports 3000 and 3001 are available
   - Check if other services are using these ports
   - Modify ports in `.env` if needed

3. **Docker Issues**
   - Clean Docker cache: `docker system prune -a`
   - Rebuild containers: `docker-compose up --build --force-recreate`
   - Check Docker logs: `docker-compose logs`

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
