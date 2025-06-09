# Build stage
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./
COPY frontend/package*.json ./frontend/
COPY backend/package*.json ./backend/

# Install dependencies
RUN npm run install:all

# Copy the rest of the application
COPY . .

# Build the frontend application
RUN npm run build:frontend

# Production stage
FROM node:18-alpine AS runner

# Install OpenSSL
RUN apk add --no-cache openssl

WORKDIR /app

# Copy necessary files from builder
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/frontend/.next ./frontend/.next
COPY --from=builder /app/frontend/public ./frontend/public
COPY --from=builder /app/frontend/package*.json ./frontend/
COPY --from=builder /app/backend/src ./backend/src
COPY --from=builder /app/backend/package*.json ./backend/
COPY --from=builder /app/prisma ./prisma

# Create backend src directory if it doesn't exist
RUN mkdir -p backend/src

# Install production dependencies and concurrently globally
RUN npm install --production && \
    npm install -g concurrently && \
    cd frontend && npm install --production && \
    cd ../backend && npm install --production

# Create and set up startup script
RUN echo '#!/bin/sh' > /app/start.sh && \
    echo 'echo "Waiting for database..."' >> /app/start.sh && \
    echo 'npx prisma generate' >> /app/start.sh && \
    echo 'npx prisma migrate deploy' >> /app/start.sh && \
    echo 'echo "Starting application..."' >> /app/start.sh && \
    echo 'cd /app && /usr/local/bin/concurrently "npm run start:frontend" "npm run start:backend"' >> /app/start.sh && \
    chmod +x /app/start.sh

# Set environment variables
ENV NODE_ENV=production
ENV PATH="/usr/local/bin:${PATH}"

# Expose ports
EXPOSE 3000 3001

# Start the application using the startup script
CMD ["sh", "/app/start.sh"] 