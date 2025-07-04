# Models

This directory contains data models that define the structure and relationships of database entities using Sequelize ORM.

## Purpose

Models provide:
- Database table definitions
- Data validation rules
- Relationships between entities
- Business logic methods
- Data transformation and formatting
- Database migration support

## File Structure

```
models/
├── User.js              # User model
├── Movie.js             # Movie model
├── Rating.js            # User movie ratings
├── Watchlist.js         # User watchlists
├── Genre.js             # Movie genres
├── index.js             # Model associations and exports
└── migrations/          # Database migration files
    ├── 001_create_users.js
    ├── 002_create_movies.js
    └── 003_create_ratings.js
```

## Model Pattern

Each model follows the Sequelize pattern:

```javascript
// Example model structure
const { DataTypes } = require('sequelize');
const sequelize = require('../config/sequelize');

const ModelName = sequelize.define('ModelName', {
  // Column definitions
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  name: {
    type: DataTypes.STRING,
    allowNull: false,
    validate: {
      len: [2, 100]
    }
  },
  // ... other columns
}, {
  // Model options
  tableName: 'table_name',
  timestamps: true,
  underscored: true
});

// Instance methods
ModelName.prototype.customMethod = function() {
  // Instance-specific logic
};

// Class methods
ModelName.findByCustom = function(criteria) {
  // Static query methods
};

module.exports = ModelName;
```

## Model Definitions

### `User.js`
User account and profile information.

**Fields:**
- `id` - Primary key
- `email` - Unique email address
- `password` - Hashed password
- `username` - Display name
- `first_name` - First name
- `last_name` - Last name
- `preferences` - JSON user preferences
- `created_at` - Account creation date
- `updated_at` - Last update date

**Relationships:**
- Has many Ratings
- Has many Watchlists
- Has many UserGenres (preferences)

### `Movie.js`
Movie information and metadata.

**Fields:**
- `id` - Primary key
- `title` - Movie title
- `overview` - Movie description
- `poster_path` - Poster image URL
- `backdrop_path` - Background image URL
- `release_date` - Release date
- `vote_average` - Average rating
- `vote_count` - Number of votes
- `popularity` - Popularity score
- `runtime` - Movie duration
- `status` - Movie status (released, upcoming, etc.)

**Relationships:**
- Has many Ratings
- Has many MovieGenres
- Has many Watchlists

### `Rating.js`
User movie ratings and reviews.

**Fields:**
- `id` - Primary key
- `user_id` - Foreign key to User
- `movie_id` - Foreign key to Movie
- `rating` - Rating value (1-10)
- `review` - Optional review text
- `created_at` - Rating date
- `updated_at` - Last update date

**Relationships:**
- Belongs to User
- Belongs to Movie

### `Watchlist.js`
User movie watchlists.

**Fields:**
- `id` - Primary key
- `user_id` - Foreign key to User
- `movie_id` - Foreign key to Movie
- `status` - Watchlist status (planned, watching, completed)
- `priority` - Priority level
- `notes` - User notes
- `created_at` - Added date
- `updated_at` - Last update date

**Relationships:**
- Belongs to User
- Belongs to Movie

### `Genre.js`
Movie genres and categories.

**Fields:**
- `id` - Primary key
- `name` - Genre name
- `description` - Genre description
- `created_at` - Creation date

**Relationships:**
- Has many MovieGenres
- Has many UserGenres

## Model Associations

Associations are defined in `index.js`:

```javascript
// One-to-Many relationships
User.hasMany(Rating);
Rating.belongsTo(User);

User.hasMany(Watchlist);
Watchlist.belongsTo(User);

Movie.hasMany(Rating);
Rating.belongsTo(Movie);

Movie.hasMany(Watchlist);
Watchlist.belongsTo(Movie);

// Many-to-Many relationships
Movie.belongsToMany(Genre, { through: 'MovieGenres' });
Genre.belongsToMany(Movie, { through: 'MovieGenres' });

User.belongsToMany(Genre, { through: 'UserGenres' });
Genre.belongsToMany(User, { through: 'UserGenres' });
```

## Data Validation

Models include validation rules:

```javascript
// Example validation
email: {
  type: DataTypes.STRING,
  allowNull: false,
  unique: true,
  validate: {
    isEmail: true,
    len: [5, 255]
  }
},

rating: {
  type: DataTypes.INTEGER,
  allowNull: false,
  validate: {
    min: 1,
    max: 10
  }
}
```

## Hooks and Lifecycle

Models can include lifecycle hooks:

```javascript
// Before save hook
User.beforeSave(async (user) => {
  if (user.changed('password')) {
    user.password = await bcrypt.hash(user.password, 10);
  }
});

// After find hook
Movie.afterFind((movies) => {
  // Transform data after retrieval
});
```

## Migration Files

Database migrations are stored in `migrations/`:

- `001_create_users.js` - Create users table
- `002_create_movies.js` - Create movies table
- `003_create_ratings.js` - Create ratings table
- `004_add_indexes.js` - Add performance indexes

## Usage Examples

```javascript
const { User, Movie, Rating } = require('../models');

// Create a new user
const user = await User.create({
  email: 'user@example.com',
  password: 'hashedPassword',
  username: 'movie_lover'
});

// Find user with ratings
const userWithRatings = await User.findByPk(userId, {
  include: [{
    model: Rating,
    include: [Movie]
  }]
});

// Get movie recommendations
const recommendations = await Movie.findAll({
  include: [{
    model: Rating,
    where: { rating: { [Op.gte]: 8 } }
  }],
  order: [['vote_average', 'DESC']]
});
```

## Testing Models

Each model should have tests:
- Unit tests for validation
- Integration tests with database
- Test associations and relationships
- Test hooks and lifecycle methods
- Test custom methods 