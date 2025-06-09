# Movie Recommendation System

A full-stack movie recommendation system built with Next.js, Express, and PostgreSQL.

## Project Structure

```
movie-recommendation/
├── frontend/           # Next.js frontend application
├── backend/           # Express.js backend server
├── Dockerfile         # Docker configuration for the application
├── docker-compose.yml # Docker Compose configuration
└── .dockerignore     # Docker ignore rules
```

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Setup and Running

### Using Docker (Recommended)

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd movie-recommendation
   ```

2. Create a `.env` file in the root directory with the following variables:
   ```env
   # Frontend
   NEXT_PUBLIC_API_URL=http://localhost:3001

   # Backend
   PORT=3001
   DATABASE_URL=postgresql://postgres:postgres@db:5432/movie_recommendation
   JWT_SECRET=your_jwt_secret_here

   # Database
   POSTGRES_USER=postgres
   POSTGRES_PASSWORD=postgres
   POSTGRES_DB=movie_recommendation
   ```

3. Build and start the containers:
   ```bash
   docker-compose up --build
   ```

   This will start:
   - Frontend at http://localhost:3000
   - Backend API at http://localhost:3001
   - PostgreSQL database at localhost:5432

4. To stop the containers:
   ```bash
   docker-compose down
   ```

### Manual Setup (Alternative)

If you prefer to run the services without Docker:

1. Install PostgreSQL locally and create a database named `movie_recommendation`

2. Set up the backend:
   ```bash
   cd backend
   npm install
   npm run dev
   ```

3. Set up the frontend:
   ```bash
   cd frontend
   npm install
   npm run dev
   ```

## Development

- Frontend development server runs on http://localhost:3000
- Backend API server runs on http://localhost:3001
- API documentation is available at http://localhost:3001/api-docs

## Environment Variables

Make sure to set up the following environment variables:

### Frontend (.env.local)
- `NEXT_PUBLIC_API_URL`: URL of the backend API

### Backend (.env)
- `PORT`: Backend server port
- `DATABASE_URL`: PostgreSQL connection string
- `JWT_SECRET`: Secret key for JWT authentication

### Database (docker-compose.yml)
- `POSTGRES_USER`: PostgreSQL username
- `POSTGRES_PASSWORD`: PostgreSQL password
- `POSTGRES_DB`: Database name

## Available Scripts

### Frontend
- `npm run dev`: Start development server
- `npm run build`: Build for production
- `npm start`: Start production server

### Backend
- `npm run dev`: Start development server
- `npm run build`: Build for production
- `npm start`: Start production server

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
