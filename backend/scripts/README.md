# Scripts

This directory contains utility scripts for development, deployment, and maintenance tasks.

## Purpose

Scripts provide:
- Development automation
- Database management
- Deployment automation
- Data seeding and migration
- Performance monitoring
- Maintenance tasks

## File Structure

```
scripts/
├── development/          # Development scripts
│   ├── setup-dev.js      # Development environment setup
│   ├── seed-data.js      # Seed database with test data
│   ├── reset-db.js       # Reset database
│   └── watch-changes.js  # Watch for file changes
├── database/             # Database management scripts
│   ├── migrate.js        # Run database migrations
│   ├── seed.js           # Seed database
│   ├── backup.js         # Database backup
│   └── restore.js        # Database restore
├── deployment/           # Deployment scripts
│   ├── build.js          # Build application
│   ├── deploy.js         # Deploy to production
│   ├── rollback.js       # Rollback deployment
│   └── health-check.js   # Health check script
├── maintenance/          # Maintenance scripts
│   ├── cleanup-logs.js   # Clean up log files
│   ├── optimize-db.js    # Database optimization
│   └── monitor.js        # System monitoring
└── utils/                # Utility scripts
    ├── generate-docs.js  # Generate documentation
    ├── validate-env.js   # Validate environment
    └── performance-test.js # Performance testing
```

## Development Scripts

### Setup Development Environment (`development/setup-dev.js`)
Automates development environment setup.

**Features:**
- Install dependencies
- Set up environment variables
- Initialize database
- Create test data
- Start development server

```javascript
// Example setup script
const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

async function setupDev() {
  console.log('Setting up development environment...');
  
  // Install dependencies
  execSync('npm install', { stdio: 'inherit' });
  
  // Create .env file if it doesn't exist
  if (!fs.existsSync('.env')) {
    const envTemplate = fs.readFileSync('.env.example', 'utf8');
    fs.writeFileSync('.env', envTemplate);
    console.log('Created .env file from template');
  }
  
  // Initialize database
  execSync('npm run db:setup', { stdio: 'inherit' });
  
  // Seed test data
  execSync('npm run db:seed', { stdio: 'inherit' });
  
  console.log('Development environment setup complete!');
}

setupDev().catch(console.error);
```

### Seed Data (`development/seed-data.js`)
Populates database with test data.

**Features:**
- Create test users
- Add sample movies
- Generate ratings
- Create watchlists
- Add genres

```javascript
// Example seed script
const { User, Movie, Rating, Genre } = require('../src/models');

async function seedData() {
  console.log('Seeding database with test data...');
  
  // Create genres
  const genres = await Genre.bulkCreate([
    { name: 'Action', description: 'Action movies' },
    { name: 'Drama', description: 'Drama movies' },
    { name: 'Comedy', description: 'Comedy movies' },
    { name: 'Horror', description: 'Horror movies' },
    { name: 'Sci-Fi', description: 'Science fiction movies' }
  ]);
  
  // Create test users
  const users = await User.bulkCreate([
    {
      email: 'test1@example.com',
      password: 'password123',
      username: 'testuser1'
    },
    {
      email: 'test2@example.com',
      password: 'password123',
      username: 'testuser2'
    }
  ]);
  
  // Create sample movies
  const movies = await Movie.bulkCreate([
    {
      title: 'Sample Movie 1',
      overview: 'A sample movie for testing',
      release_date: '2024-01-01',
      vote_average: 8.5
    },
    {
      title: 'Sample Movie 2',
      overview: 'Another sample movie',
      release_date: '2024-02-01',
      vote_average: 7.8
    }
  ]);
  
  console.log('Database seeded successfully!');
}

seedData().catch(console.error);
```

## Database Scripts

### Migration Script (`database/migrate.js`)
Runs database migrations.

**Features:**
- Run pending migrations
- Rollback migrations
- Check migration status
- Create migration files

```javascript
// Example migration script
const { Sequelize } = require('sequelize');
const path = require('path');

async function runMigrations() {
  const sequelize = new Sequelize(process.env.DATABASE_URL);
  
  try {
    await sequelize.authenticate();
    console.log('Database connection established.');
    
    // Run migrations
    await sequelize.runMigrations();
    console.log('Migrations completed successfully.');
    
  } catch (error) {
    console.error('Migration failed:', error);
    process.exit(1);
  } finally {
    await sequelize.close();
  }
}

runMigrations();
```

### Database Backup (`database/backup.js`)
Creates database backups.

**Features:**
- Full database backup
- Incremental backups
- Compressed backups
- Backup scheduling

```javascript
// Example backup script
const { exec } = require('child_process');
const path = require('path');

async function backupDatabase() {
  const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
  const backupPath = path.join(__dirname, `../backups/backup-${timestamp}.sql`);
  
  const command = `pg_dump ${process.env.DATABASE_URL} > ${backupPath}`;
  
  exec(command, (error, stdout, stderr) => {
    if (error) {
      console.error('Backup failed:', error);
      return;
    }
    console.log(`Database backed up to: ${backupPath}`);
  });
}

backupDatabase();
```

## Deployment Scripts

### Build Script (`deployment/build.js`)
Builds application for production.

**Features:**
- Install production dependencies
- Build assets
- Optimize code
- Create production bundle

```javascript
// Example build script
const { execSync } = require('child_process');
const fs = require('fs');

async function build() {
  console.log('Building application for production...');
  
  // Clean previous build
  if (fs.existsSync('dist')) {
    fs.rmSync('dist', { recursive: true });
  }
  
  // Install production dependencies
  execSync('npm ci --only=production', { stdio: 'inherit' });
  
  // Run tests
  execSync('npm test', { stdio: 'inherit' });
  
  // Build application
  execSync('npm run build', { stdio: 'inherit' });
  
  console.log('Build completed successfully!');
}

build().catch(console.error);
```

### Health Check (`deployment/health-check.js`)
Performs health checks on deployed application.

**Features:**
- API endpoint health checks
- Database connectivity check
- External service checks
- Performance monitoring

```javascript
// Example health check script
const axios = require('axios');

async function healthCheck() {
  const baseUrl = process.env.API_URL || 'http://localhost:3001';
  
  try {
    // Check API health
    const healthResponse = await axios.get(`${baseUrl}/api/health`);
    console.log('API Health:', healthResponse.data);
    
    // Check database connection
    const dbResponse = await axios.get(`${baseUrl}/api/health/database`);
    console.log('Database Health:', dbResponse.data);
    
    // Check external services
    const externalResponse = await axios.get(`${baseUrl}/api/health/external`);
    console.log('External Services Health:', externalResponse.data);
    
    console.log('All health checks passed!');
    
  } catch (error) {
    console.error('Health check failed:', error.message);
    process.exit(1);
  }
}

healthCheck();
```

## Maintenance Scripts

### Log Cleanup (`maintenance/cleanup-logs.js`)
Cleans up old log files.

**Features:**
- Remove old log files
- Compress logs
- Archive logs
- Monitor disk usage

```javascript
// Example log cleanup script
const fs = require('fs');
const path = require('path');

async function cleanupLogs() {
  const logDir = path.join(__dirname, '../logs');
  const maxAge = 30 * 24 * 60 * 60 * 1000; // 30 days
  
  if (!fs.existsSync(logDir)) {
    console.log('Log directory does not exist');
    return;
  }
  
  const files = fs.readdirSync(logDir);
  const now = Date.now();
  
  files.forEach(file => {
    const filePath = path.join(logDir, file);
    const stats = fs.statSync(filePath);
    
    if (now - stats.mtime.getTime() > maxAge) {
      fs.unlinkSync(filePath);
      console.log(`Deleted old log file: ${file}`);
    }
  });
  
  console.log('Log cleanup completed');
}

cleanupLogs();
```

### Database Optimization (`maintenance/optimize-db.js`)
Optimizes database performance.

**Features:**
- Analyze table statistics
- Update indexes
- Vacuum database
- Monitor performance

```javascript
// Example database optimization script
const { pool } = require('../src/config/database');

async function optimizeDatabase() {
  try {
    // Analyze tables
    await pool.query('ANALYZE');
    console.log('Table analysis completed');
    
    // Update statistics
    await pool.query('VACUUM ANALYZE');
    console.log('Database vacuum and analyze completed');
    
    // Check for unused indexes
    const unusedIndexes = await pool.query(`
      SELECT schemaname, tablename, indexname 
      FROM pg_stat_user_indexes 
      WHERE idx_scan = 0
    `);
    
    if (unusedIndexes.rows.length > 0) {
      console.log('Unused indexes found:', unusedIndexes.rows);
    }
    
    console.log('Database optimization completed');
    
  } catch (error) {
    console.error('Database optimization failed:', error);
  } finally {
    await pool.end();
  }
}

optimizeDatabase();
```

## Utility Scripts

### Generate Documentation (`utils/generate-docs.js`)
Automatically generates API documentation.

**Features:**
- Generate OpenAPI specification
- Create Postman collection
- Update README files
- Generate code documentation

### Environment Validation (`utils/validate-env.js`)
Validates environment configuration.

**Features:**
- Check required environment variables
- Validate database connection
- Test external API connections
- Verify file permissions

### Performance Testing (`utils/performance-test.js`)
Runs performance tests.

**Features:**
- Load testing
- Stress testing
- Performance benchmarking
- Memory usage monitoring

## Script Usage

### Running Scripts
```bash
# Development setup
node scripts/development/setup-dev.js

# Seed database
node scripts/development/seed-data.js

# Run migrations
node scripts/database/migrate.js

# Backup database
node scripts/database/backup.js

# Build application
node scripts/deployment/build.js

# Health check
node scripts/deployment/health-check.js

# Cleanup logs
node scripts/maintenance/cleanup-logs.js
```

### Package.json Scripts
```json
{
  "scripts": {
    "setup": "node scripts/development/setup-dev.js",
    "seed": "node scripts/development/seed-data.js",
    "migrate": "node scripts/database/migrate.js",
    "backup": "node scripts/database/backup.js",
    "build": "node scripts/deployment/build.js",
    "health-check": "node scripts/deployment/health-check.js",
    "cleanup": "node scripts/maintenance/cleanup-logs.js"
  }
}
```

## Best Practices

- Use descriptive script names
- Include error handling
- Add logging and progress indicators
- Make scripts idempotent
- Use environment variables for configuration
- Test scripts before deployment
- Document script dependencies
- Use proper exit codes
- Implement rollback mechanisms 