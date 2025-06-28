-- Movie Database Initialization Script
-- Refactored for new schema with media_content as base table

-- ENUM type definitions
CREATE TYPE status_enum AS ENUM ('Pending', 'Success', 'Failed');
CREATE TYPE role_enum AS ENUM ('actor', 'director');
CREATE TYPE video_type_enum AS ENUM ('trailer', 'episode', 'movie');
CREATE TYPE video_quality_enum AS ENUM ('HD', 'FHD', '4K_UHD');
CREATE TYPE transaction_type_enum AS ENUM ('subscription', 'pay_per_view');
CREATE TYPE series_status_enum AS ENUM ('ongoing', 'completed', 'cancelled');
CREATE TYPE movie_status_enum AS ENUM ('upcoming', 'released', 'cancelled', 'postponed');

-- Create subscription plans table
CREATE TABLE IF NOT EXISTS subscription_plans (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    description TEXT,
    cost DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Create accounts table
CREATE TABLE IF NOT EXISTS accounts (
    user_profile_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    subscription_plan_id UUID NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    email_address VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (subscription_plan_id) REFERENCES subscription_plans(id)
);

-- 4. Các bảng người dùng và giao dịch
CREATE TABLE IF NOT EXISTS user_settings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    autoplay_next BOOLEAN NOT NULL DEFAULT true,
    preferred_quality VARCHAR(20) NOT NULL DEFAULT 'HD',
    language_preferences VARCHAR(50) NOT NULL DEFAULT 'en',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS user_profiles (
    profile_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    profile_name VARCHAR(100) NOT NULL,
    search_history TEXT,
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
    date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    type video_type_enum NOT NULL,
    quality_purchased video_quality_enum,
    plan_type transaction_type_enum,
    user_profile_id UUID NOT NULL,
    FOREIGN KEY (user_profile_id) REFERENCES user_profiles(profile_id)
);

-- 5. TV Series và phân cấp
CREATE TABLE IF NOT EXISTS tv_series (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    media_content_id UUID NOT NULL UNIQUE REFERENCES media_content(id) ON DELETE CASCADE,
    total_of_seasons INTEGER NOT NULL DEFAULT 1 CHECK (total_of_seasons > 0),
    total_of_episodes INTEGER NOT NULL DEFAULT 0 CHECK (total_of_episodes >= 0),
    nation_id UUID NOT NULL REFERENCES nations(id),
    status VARCHAR(20) NOT NULL DEFAULT 'ongoing' CHECK (status IN ('ongoing','completed','cancelled')),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS seasons (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tv_series_id UUID NOT NULL REFERENCES tv_series(id) ON DELETE CASCADE,
    season_number INTEGER NOT NULL CHECK (season_number > 0),
    number_of_episodes INTEGER NOT NULL DEFAULT 0 CHECK (number_of_episodes >= 0),
    release_date DATE,
    title VARCHAR(255),
    description TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS episodes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    season_id UUID NOT NULL REFERENCES seasons(id) ON DELETE CASCADE,
    episode_number INTEGER NOT NULL CHECK (episode_number > 0),
    title VARCHAR(255) NOT NULL,
    duration_in_minutes INTEGER NOT NULL CHECK (duration_in_minutes > 0),
    release_date DATE,
    description TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Create topics table
CREATE TABLE IF NOT EXISTS topics (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    topic_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create media_content table (base table for movies and TV series)
CREATE TABLE IF NOT EXISTS media_content (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    year INTEGER NOT NULL CHECK (year >= 1900 AND year <= 2030),
    view_count INTEGER DEFAULT 0,
    average_rating DECIMAL(3,2) DEFAULT 0 CHECK (average_rating >= 0 AND average_rating <= 10),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create movies table
CREATE TABLE IF NOT EXISTS movies (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    media_content_id UUID NOT NULL UNIQUE,
    duration_in_minutes INTEGER NOT NULL CHECK (duration_in_minutes > 0),
    price_movie DECIMAL(10,2) CHECK (price_movie >= 0),
    nation_id UUID NOT NULL,
    type VARCHAR(50) DEFAULT 'movie',
    status movie_status_enum DEFAULT 'released',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (media_content_id) REFERENCES media_content(id) ON DELETE CASCADE,
    FOREIGN KEY (nation_id) REFERENCES nations(id)
);

-- Create tv_series table
CREATE TABLE IF NOT EXISTS tv_series (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    media_content_id UUID NOT NULL UNIQUE,
    total_of_seasons INTEGER NOT NULL DEFAULT 1 CHECK (total_of_seasons > 0),
    total_of_episodes INTEGER NOT NULL DEFAULT 0 CHECK (total_of_episodes >= 0),
    nation_id UUID NOT NULL,
    status series_status_enum DEFAULT 'ongoing',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (media_content_id) REFERENCES media_content(id) ON DELETE CASCADE,
    FOREIGN KEY (nation_id) REFERENCES nations(id)
);

-- Create seasons table
CREATE TABLE IF NOT EXISTS seasons (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tv_series_id UUID NOT NULL,
    season_number INTEGER NOT NULL CHECK (season_number > 0),
    number_of_episodes INTEGER NOT NULL DEFAULT 0 CHECK (number_of_episodes >= 0),
    release_date DATE,
    title VARCHAR(255),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (tv_series_id) REFERENCES tv_series(id) ON DELETE CASCADE
);

-- Create episodes table
CREATE TABLE IF NOT EXISTS episodes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    season_id UUID NOT NULL,
    episode_number INTEGER NOT NULL CHECK (episode_number > 0),
    title VARCHAR(255) NOT NULL,
    duration_in_minutes INTEGER NOT NULL CHECK (duration_in_minutes > 0),
    release_date DATE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (season_id) REFERENCES seasons(id) ON DELETE CASCADE
);

-- Create media_content_genres junction table
CREATE TABLE IF NOT EXISTS media_content_genres (
    media_content_id UUID NOT NULL,
    genre_id UUID NOT NULL,
    PRIMARY KEY (media_content_id, genre_id),
    FOREIGN KEY (media_content_id) REFERENCES media_content(id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE CASCADE
);

-- Create media_content_creatives junction table
CREATE TABLE IF NOT EXISTS media_content_creatives (
    media_content_id UUID NOT NULL,
    creative_id UUID NOT NULL,
    PRIMARY KEY (media_content_id, creative_id),
    FOREIGN KEY (media_content_id) REFERENCES media_content(id) ON DELETE CASCADE,
    FOREIGN KEY (creative_id) REFERENCES creatives(creative_id) ON DELETE CASCADE
);

-- Create media_content_topics junction table
CREATE TABLE IF NOT EXISTS media_content_topics (
    media_content_id UUID NOT NULL,
    topic_id UUID NOT NULL,
    PRIMARY KEY (media_content_id, topic_id),
    FOREIGN KEY (media_content_id) REFERENCES media_content(id) ON DELETE CASCADE,
    FOREIGN KEY (topic_id) REFERENCES topics(id) ON DELETE CASCADE
);

-- Create videos table
CREATE TABLE IF NOT EXISTS videos (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    movie_id UUID,
    episode_id UUID,
    type video_type_enum NOT NULL,
    file_path VARCHAR(500),
    quality video_quality_enum NOT NULL,
    duration_minutes INTEGER CHECK (duration_minutes > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
    FOREIGN KEY (episode_id) REFERENCES episodes(id) ON DELETE CASCADE,
    CHECK ((movie_id IS NOT NULL AND episode_id IS NULL) OR (movie_id IS NULL AND episode_id IS NOT NULL))
);

-- Create ratings table
CREATE TABLE IF NOT EXISTS ratings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_profile_id UUID NOT NULL,
    media_content_id UUID,
    episode_id UUID,
    rating DECIMAL(3,2) NOT NULL CHECK (rating >= 0 AND rating <= 10),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_profile_id) REFERENCES user_profiles(profile_id) ON DELETE CASCADE,
    FOREIGN KEY (media_content_id) REFERENCES media_content(id) ON DELETE CASCADE,
    FOREIGN KEY (episode_id) REFERENCES episodes(id) ON DELETE CASCADE,
    CHECK ((media_content_id IS NOT NULL AND episode_id IS NULL) OR (media_content_id IS NULL AND episode_id IS NOT NULL)),
    UNIQUE(user_profile_id, media_content_id),
    UNIQUE(user_profile_id, episode_id)
);

-- Create comments table
CREATE TABLE IF NOT EXISTS comments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_profile_id UUID NOT NULL,
    media_content_id UUID,
    episode_id UUID,
    comment_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_profile_id) REFERENCES user_profiles(profile_id) ON DELETE CASCADE,
    FOREIGN KEY (media_content_id) REFERENCES media_content(id) ON DELETE CASCADE,
    FOREIGN KEY (episode_id) REFERENCES episodes(id) ON DELETE CASCADE,
    CHECK ((media_content_id IS NOT NULL AND episode_id IS NULL) OR (media_content_id IS NULL AND episode_id IS NOT NULL))
);

CREATE TABLE IF NOT EXISTS user_interaction_metrics (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_profile_id UUID NOT NULL,
    media_content_id UUID,
    episode_id UUID,
    watch_time_minutes INTEGER DEFAULT 0,
    completion_percentage DECIMAL(5,2) DEFAULT 0.00 CHECK (completion_percentage >= 0 AND completion_percentage <= 100),
    last_watched_at TIMESTAMP,
    watch_count INTEGER DEFAULT 0,
    bookmarked BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_profile_id) REFERENCES user_profiles(profile_id) ON DELETE CASCADE,
    FOREIGN KEY (media_content_id) REFERENCES media_content(id) ON DELETE CASCADE,
    FOREIGN KEY (episode_id) REFERENCES episodes(id) ON DELETE CASCADE,
    CHECK ((media_content_id IS NOT NULL AND episode_id IS NULL) OR (media_content_id IS NULL AND episode_id IS NOT NULL)),
    UNIQUE(user_profile_id, media_content_id),
    UNIQUE(user_profile_id, episode_id)
);

-- Create recommendation engine tags table
CREATE TABLE IF NOT EXISTS recommendation_engine_tags (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    media_content_id UUID NOT NULL,
    mood VARCHAR(100),
    pacing VARCHAR(100),
    audience_type VARCHAR(100),
    theme VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (media_content_id) REFERENCES media_content(id) ON DELETE CASCADE
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_media_content_name ON media_content(name);
CREATE INDEX IF NOT EXISTS idx_media_content_year ON media_content(year);
CREATE INDEX IF NOT EXISTS idx_media_content_rating ON media_content(average_rating);
CREATE INDEX IF NOT EXISTS idx_movies_media_content_id ON movies(media_content_id);
CREATE INDEX IF NOT EXISTS idx_tv_series_media_content_id ON tv_series(media_content_id);
CREATE INDEX IF NOT EXISTS idx_seasons_tv_series_id ON seasons(tv_series_id);
CREATE INDEX IF NOT EXISTS idx_episodes_season_id ON episodes(season_id);
CREATE INDEX IF NOT EXISTS idx_ratings_media_content_id ON ratings(media_content_id);
CREATE INDEX IF NOT EXISTS idx_ratings_episode_id ON ratings(episode_id);
CREATE INDEX IF NOT EXISTS idx_ratings_user_profile_id ON ratings(user_profile_id);
CREATE INDEX IF NOT EXISTS idx_comments_media_content_id ON comments(media_content_id);
CREATE INDEX IF NOT EXISTS idx_comments_episode_id ON comments(episode_id);
CREATE INDEX IF NOT EXISTS idx_comments_user_profile_id ON comments(user_profile_id);
CREATE INDEX IF NOT EXISTS idx_user_interaction_metrics_media_content_id ON user_interaction_metrics(media_content_id);
CREATE INDEX IF NOT EXISTS idx_user_interaction_metrics_episode_id ON user_interaction_metrics(episode_id);
CREATE INDEX IF NOT EXISTS idx_user_interaction_metrics_user_profile_id ON user_interaction_metrics(user_profile_id);
CREATE INDEX IF NOT EXISTS idx_videos_movie_id ON videos(movie_id);
CREATE INDEX IF NOT EXISTS idx_videos_episode_id ON videos(episode_id);
CREATE INDEX IF NOT EXISTS idx_videos_type ON videos(type);
CREATE INDEX IF NOT EXISTS idx_videos_quality ON videos(quality);

-- Create views for common queries
CREATE OR REPLACE VIEW movie_details AS
SELECT 
    mc.id,
    mc.name,
    mc.description,
    mc.year,
    mc.view_count,
    mc.average_rating,
    m.duration_in_minutes,
    m.price_movie,
    m.type,
    m.status,
    n.name as country,
    STRING_AGG(DISTINCT g.name, ', ') as genres,
    STRING_AGG(DISTINCT CASE WHEN c.role = 'director' THEN c.name END, ', ') as directors,
    STRING_AGG(DISTINCT CASE WHEN c.role = 'actor' THEN c.name END, ', ') as actors
FROM media_content mc
JOIN movies m ON mc.id = m.media_content_id
LEFT JOIN nations n ON m.nation_id = n.id
LEFT JOIN media_content_genres mcg ON mc.id = mcg.media_content_id
LEFT JOIN genres g ON mcg.genre_id = g.id
LEFT JOIN media_content_creatives mcc ON mc.id = mcc.media_content_id
LEFT JOIN creatives c ON mcc.creative_id = c.creative_id
GROUP BY mc.id, mc.name, mc.description, mc.year, mc.view_count, mc.average_rating, 
         m.duration_in_minutes, m.price_movie, m.type, m.status, n.name;

CREATE OR REPLACE VIEW tv_series_details AS
SELECT 
    mc.id,
    mc.name,
    mc.description,
    mc.year,
    mc.view_count,
    mc.average_rating,
    ts.total_of_seasons,
    ts.total_of_episodes,
    ts.status,
    n.name as country,
    STRING_AGG(DISTINCT g.name, ', ') as genres,
    STRING_AGG(DISTINCT CASE WHEN c.role = 'director' THEN c.name END, ', ') as directors,
    STRING_AGG(DISTINCT CASE WHEN c.role = 'actor' THEN c.name END, ', ') as actors
FROM media_content mc
JOIN tv_series ts ON mc.id = ts.media_content_id
LEFT JOIN nations n ON ts.nation_id = n.id
LEFT JOIN media_content_genres mcg ON mc.id = mcg.media_content_id
LEFT JOIN genres g ON mcg.genre_id = g.id
LEFT JOIN media_content_creatives mcc ON mc.id = mcc.media_content_id
LEFT JOIN creatives c ON mcc.creative_id = c.creative_id
GROUP BY mc.id, mc.name, mc.description, mc.year, mc.view_count, mc.average_rating, 
         ts.total_of_seasons, ts.total_of_episodes, ts.status, n.name;

CREATE OR REPLACE VIEW episode_details AS
SELECT 
    e.id,
    e.title,
    e.episode_number,
    e.duration_in_minutes,
    e.release_date,
    e.description,
    s.season_number,
    s.title as season_title,
    mc.name as series_name,
    mc.id as media_content_id
FROM episodes e
JOIN seasons s ON e.season_id = s.id
JOIN tv_series ts ON s.tv_series_id = ts.id
JOIN media_content mc ON ts.media_content_id = mc.id;

-- Create view for user statistics
CREATE OR REPLACE VIEW user_stats AS
SELECT 
    up.profile_id,
    up.profile_name,
    COUNT(DISTINCT r.media_content_id) + COUNT(DISTINCT r.episode_id) as total_rated,
    AVG(r.rating) as average_rating_given,
    COUNT(DISTINCT c.media_content_id) + COUNT(DISTINCT c.episode_id) as total_commented,
    COUNT(DISTINCT uim.media_content_id) + COUNT(DISTINCT uim.episode_id) as total_watched,
    SUM(uim.watch_time_minutes) as total_watch_time_minutes
FROM user_profiles up
LEFT JOIN ratings r ON up.profile_id = r.user_profile_id
LEFT JOIN comments c ON up.profile_id = c.user_profile_id
LEFT JOIN user_interaction_metrics uim ON up.profile_id = uim.user_profile_id
GROUP BY up.profile_id, up.profile_name;