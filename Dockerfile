# Build stage
FROM node:20-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./
COPY frontend/package*.json ./frontend/
COPY backend/package*.json ./backend/

# Install dependencies and crypto polyfill
RUN apk add --no-cache openssl && \
    npm run install:all && \
    cd frontend && \
    npm install assert buffer crypto-browserify https-browserify os-browserify process stream-browserify stream-http url util critters css-what && \
    cd ..

# Copy the rest of the application
COPY . .

# Build the frontend application
ENV NODE_OPTIONS="--openssl-legacy-provider"
ENV NEXT_TELEMETRY_DISABLED=1
RUN cd frontend && npm run build

# Production stage
FROM node:20-alpine AS runner

# Install OpenSSL and other dependencies
RUN apk add --no-cache openssl

WORKDIR /app

# Copy necessary files from builder
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/frontend/.next ./frontend/.next
COPY --from=builder /app/frontend/public ./frontend/public
COPY --from=builder /app/frontend/package*.json ./frontend/
COPY --from=builder /app/backend/src ./backend/src
COPY --from=builder /app/backend/package*.json ./backend/

# Create backend src directory if it doesn't exist
RUN mkdir -p backend/src

# Install production dependencies
RUN npm install --production && \
    cd frontend && \
    npm install --production && \
    cd ../backend && \
    npm install --production

# Create and set up startup script
RUN echo '#!/bin/sh' > /app/start.sh && \
    echo 'echo "Starting application..."' >> /app/start.sh && \
    echo 'cd /app && npm run start:frontend & npm run start:backend' >> /app/start.sh && \
    chmod +x /app/start.sh

# Set environment variables
ENV NODE_ENV=production
ENV PATH="/usr/local/bin:${PATH}"
ENV NODE_OPTIONS="--openssl-legacy-provider"
ENV NEXT_TELEMETRY_DISABLED=1

# Expose ports
EXPOSE 3000 3001

# Start the application using the startup script
CMD ["sh", "/app/start.sh"] 