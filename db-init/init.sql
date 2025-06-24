-- Movie Database Initialization Script
-- Minimal adjustments for 3-person team based on original schema

-- ENUM type definitions
CREATE TYPE status_enum AS ENUM ('Pending', 'Success', 'Failed');
CREATE TYPE role_enum AS ENUM ('actor', 'director');
CREATE TYPE movie_type_enum AS ENUM ('movie', 'series');
CREATE TYPE video_type_enum AS ENUM ('trailer', 'episode', 'movie');
CREATE TYPE video_quality_enum AS ENUM ('HD', 'FHD', '4K_UHD');

-- Create subscription plans table
CREATE TABLE IF NOT EXISTS subscription_plans (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    description TEXT,
    cost DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create accounts table
CREATE TABLE IF NOT EXISTS accounts (
    user_profile_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    subscription_plan_id UUID NOT NULL,
    password_hash VARCHAR(255) NOT NULL, -- Hash passwords, don't store plain text
    email_address VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (subscription_plan_id) REFERENCES subscription_plans(id)
);

-- Create user settings table
CREATE TABLE IF NOT EXISTS user_settings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    autoplay_next BOOLEAN DEFAULT true,
    preferred_quality VARCHAR(20) DEFAULT 'HD',
    language_preferences VARCHAR(50) DEFAULT 'en',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create user profiles table
CREATE TABLE IF NOT EXISTS user_profiles (
    profile_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    profile_name VARCHAR(100) NOT NULL,
    search_history TEXT[], -- Keep as simple array for now
    user_setting_id UUID,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_setting_id) REFERENCES user_settings(id)
);

-- Create transactions table
CREATE TABLE IF NOT EXISTS transactions (
    transaction_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    status status_enum NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    type video_type_enum NOT NULL,
    quality_purchased video_quality_enum,
    plan_type VARCHAR(50),
    user_profile_id UUID NOT NULL,
    FOREIGN KEY (user_profile_id) REFERENCES accounts(user_profile_id)
);

-- Create nations table
CREATE TABLE IF NOT EXISTS nations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create genres table
CREATE TABLE IF NOT EXISTS genres (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create creatives table
CREATE TABLE IF NOT EXISTS creatives (
    creative_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    role role_enum NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create movies table (simplified)
CREATE TABLE IF NOT EXISTS movies (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    year INTEGER NOT NULL CHECK (year >= 1900 AND year <= 2030),
    summary TEXT,
    season_number INTEGER, -- NULL for movies, set for series episodes
    nation_id UUID NOT NULL,
    rating DECIMAL(3,2) CHECK (rating >= 0 AND rating <= 10),
    episode_number INTEGER, -- NULL for movies, set for series episodes  
    average_rating DECIMAL(3,2) DEFAULT 0,
    type movie_type_enum NOT NULL, -- Only movie or series
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (nation_id) REFERENCES nations(id)
);

-- Create movie_genres junction table
CREATE TABLE IF NOT EXISTS movie_genres (
    movie_id UUID NOT NULL,
    genre_id UUID NOT NULL,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE CASCADE
);

-- Create movie_creatives junction table
CREATE TABLE IF NOT EXISTS movie_creatives (
    movie_id UUID NOT NULL,
    creative_id UUID NOT NULL,
    PRIMARY KEY (movie_id, creative_id),
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
    FOREIGN KEY (creative_id) REFERENCES creatives(creative_id) ON DELETE CASCADE
);

-- Create videos table
CREATE TABLE IF NOT EXISTS videos (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    movie_id UUID NOT NULL,
    type video_type_enum NOT NULL, -- trailer, episode, or movie
    file_path VARCHAR(500),
    quality video_quality_enum NOT NULL,
    duration_minutes INTEGER CHECK (duration_minutes > 0),
    file_size_mb INTEGER CHECK (file_size_mb > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE
);

-- Create topics table
CREATE TABLE IF NOT EXISTS topics (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    topic_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create movie_topics junction table
CREATE TABLE IF NOT EXISTS movie_topics (
    movie_id UUID NOT NULL,
    topic_id UUID NOT NULL,
    PRIMARY KEY (movie_id, topic_id),
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
    FOREIGN KEY (topic_id) REFERENCES topics(id) ON DELETE CASCADE
);

-- Create ratings table
CREATE TABLE IF NOT EXISTS ratings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_profile_id UUID NOT NULL,
    movie_id UUID NOT NULL,
    rating DECIMAL(3,2) NOT NULL CHECK (rating >= 0 AND rating <= 10),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_profile_id, movie_id),
    FOREIGN KEY (user_profile_id) REFERENCES user_profiles(profile_id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE
);

-- Create comments table
CREATE TABLE IF NOT EXISTS comments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_profile_id UUID NOT NULL,
    movie_id UUID NOT NULL,
    comment_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_profile_id) REFERENCES user_profiles(profile_id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE
);

-- Create user interaction metrics table
CREATE TABLE IF NOT EXISTS user_interaction_metrics (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_profile_id UUID NOT NULL,
    movie_id UUID NOT NULL,
    watch_time_minutes INTEGER DEFAULT 0,
    completion_percentage DECIMAL(5,2) DEFAULT 0.00 CHECK (completion_percentage >= 0 AND completion_percentage <= 100),
    last_watched_at TIMESTAMP,
    watch_count INTEGER DEFAULT 0,
    bookmarked BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_profile_id, movie_id),
    FOREIGN KEY (user_profile_id) REFERENCES user_profiles(profile_id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE
);

-- Create recommendation engine tags table
CREATE TABLE IF NOT EXISTS recommendation_engine_tags (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    movie_id UUID NOT NULL,
    mood VARCHAR(100),
    pacing VARCHAR(100),
    audience_type VARCHAR(100),
    theme VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE
);


CREATE INDEX IF NOT EXISTS idx_movies_name ON movies(name);
CREATE INDEX IF NOT EXISTS idx_movies_year ON movies(year);
CREATE INDEX IF NOT EXISTS idx_movies_rating ON movies(rating);
CREATE INDEX IF NOT EXISTS idx_movies_type ON movies(type);
CREATE INDEX IF NOT EXISTS idx_ratings_movie_id ON ratings(movie_id);
CREATE INDEX IF NOT EXISTS idx_ratings_user_profile_id ON ratings(user_profile_id);
CREATE INDEX IF NOT EXISTS idx_ratings_rating ON ratings(rating);
CREATE INDEX IF NOT EXISTS idx_comments_movie_id ON comments(movie_id);
CREATE INDEX IF NOT EXISTS idx_comments_user_profile_id ON comments(user_profile_id);
CREATE INDEX IF NOT EXISTS idx_user_interaction_metrics_movie_id ON user_interaction_metrics(movie_id);
CREATE INDEX IF NOT EXISTS idx_user_interaction_metrics_user_profile_id ON user_interaction_metrics(user_profile_id);
CREATE INDEX IF NOT EXISTS idx_videos_movie_id ON videos(movie_id);
CREATE INDEX IF NOT EXISTS idx_videos_type ON videos(type);
CREATE INDEX IF NOT EXISTS idx_videos_quality ON videos(quality);

-- Create views for common queries
CREATE OR REPLACE VIEW movie_details AS
SELECT 
    m.id,
    m.name,
    m.year,
    m.summary,
    m.rating,
    m.type,
    n.name as country,
    STRING_AGG(DISTINCT g.name, ', ') as genres,
    STRING_AGG(DISTINCT CASE WHEN c.role = 'director' THEN c.name END, ', ') as directors,
    STRING_AGG(DISTINCT CASE WHEN c.role = 'actor' THEN c.name END, ', ') as actors
FROM movies m
LEFT JOIN nations n ON m.nation_id = n.id
LEFT JOIN movie_genres mg ON m.id = mg.movie_id
LEFT JOIN genres g ON mg.genre_id = g.id
LEFT JOIN movie_creatives mc ON m.id = mc.movie_id
LEFT JOIN creatives c ON mc.creative_id = c.creative_id
GROUP BY m.id, m.name, m.year, m.summary, m.rating, m.type, n.name;

-- Create view for user statistics
CREATE OR REPLACE VIEW user_stats AS
SELECT 
    up.profile_id,
    up.profile_name,
    COUNT(DISTINCT r.movie_id) as movies_rated,
    AVG(r.rating) as average_rating_given,
    COUNT(DISTINCT c.movie_id) as movies_commented,
    COUNT(DISTINCT uim.movie_id) as movies_watched,
    SUM(uim.watch_time_minutes) as total_watch_time_minutes
FROM user_profiles up
LEFT JOIN ratings r ON up.profile_id = r.user_profile_id
LEFT JOIN comments c ON up.profile_id = c.user_profile_id
LEFT JOIN user_interaction_metrics uim ON up.profile_id = uim.user_profile_id
GROUP BY up.profile_id, up.profile_name;