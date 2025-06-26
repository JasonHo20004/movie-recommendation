-- Movie Database Initialization Script
-- Minimal adjustments for 3-person team based on original schema

-- 0. Kích hoạt extension hỗ trợ gen_random_uuid()
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- 1. Định nghĩa các ENUM cần thiết
CREATE TYPE status_enum AS ENUM ('Pending', 'Success', 'Failed');
CREATE TYPE role_enum AS ENUM ('actor', 'director');
CREATE TYPE movie_type_enum AS ENUM ('movie', 'series');
CREATE TYPE video_type_enum AS ENUM ('trailer', 'episode', 'movie');
CREATE TYPE video_quality_enum AS ENUM ('HD', 'FHD', '4K_UHD');

-- 2. Bảng cha MediaContent
CREATE TABLE IF NOT EXISTS media_content (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    year INTEGER NOT NULL CHECK (year BETWEEN 1900 AND 2030),
    view_count INTEGER NOT NULL DEFAULT 0,
    average_rating DECIMAL(3,2) NOT NULL DEFAULT 0.00 CHECK (average_rating BETWEEN 0 AND 10),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 3. Bảng hỗ trợ về địa lý và phân loại (phải tạo trước khi dùng FKs)
CREATE TABLE IF NOT EXISTS nations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS genres (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS topics (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    topic_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS subscription_plans (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    description TEXT,
    cost DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS creatives (
    creative_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    role role_enum NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
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
    search_history TEXT[],
    user_setting_id UUID REFERENCES user_settings(id),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS accounts (
    user_profile_id UUID PRIMARY KEY REFERENCES user_profiles(profile_id),
    subscription_plan_id UUID NOT NULL REFERENCES subscription_plans(id),
    password_hash VARCHAR(255) NOT NULL,
    email_address VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS transactions (
    transaction_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    status status_enum NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    type video_type_enum NOT NULL,
    quality_purchased video_quality_enum,
    plan_type VARCHAR(50),
    user_profile_id UUID NOT NULL REFERENCES accounts(user_profile_id)
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

-- 6. Movie kế thừa từ MediaContent
CREATE TABLE IF NOT EXISTS movies (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    media_content_id UUID NOT NULL UNIQUE REFERENCES media_content(id) ON DELETE CASCADE,
    duration_in_minutes INTEGER NOT NULL CHECK (duration_in_minutes > 0),
    price_movie DECIMAL(10,2) NOT NULL CHECK (price_movie >= 0),
    nation_id UUID NOT NULL REFERENCES nations(id),
    rating DECIMAL(3,2) CHECK (rating BETWEEN 0 AND 10),
    type movie_type_enum NOT NULL DEFAULT 'movie',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 7. Videos, Comments, Ratings, Metrics
CREATE TABLE IF NOT EXISTS videos (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    movie_id UUID REFERENCES movies(id) ON DELETE CASCADE,
    episode_id UUID REFERENCES episodes(id) ON DELETE CASCADE,
    type video_type_enum NOT NULL,
    file_path VARCHAR(500),
    quality video_quality_enum NOT NULL,
    duration_minutes INTEGER CHECK (duration_minutes > 0),
    file_size_mb INTEGER CHECK (file_size_mb > 0),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS comments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_profile_id UUID NOT NULL REFERENCES user_profiles(profile_id) ON DELETE CASCADE,
    media_content_id UUID NOT NULL REFERENCES media_content(id) ON DELETE CASCADE,
    comment_text TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS ratings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_profile_id UUID NOT NULL REFERENCES user_profiles(profile_id) ON DELETE CASCADE,
    media_content_id UUID NOT NULL REFERENCES media_content(id) ON DELETE CASCADE,
    rating DECIMAL(3,2) NOT NULL CHECK (rating BETWEEN 0 AND 10),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (user_profile_id, media_content_id)
);

CREATE TABLE IF NOT EXISTS user_interaction_metrics (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_profile_id UUID NOT NULL REFERENCES user_profiles(profile_id) ON DELETE CASCADE,
    media_content_id UUID NOT NULL REFERENCES media_content(id) ON DELETE CASCADE,
    watch_time_minutes INTEGER NOT NULL DEFAULT 0,
    completion_percentage DECIMAL(5,2) NOT NULL DEFAULT 0.00 CHECK (completion_percentage BETWEEN 0 AND 100),
    last_watched_at TIMESTAMP,
    watch_count INTEGER NOT NULL DEFAULT 0,
    bookmarked BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (user_profile_id, media_content_id)
);

-- 8. Junction tables
CREATE TABLE IF NOT EXISTS media_content_genres (
    media_content_id UUID NOT NULL REFERENCES media_content(id) ON DELETE CASCADE,
    genre_id UUID NOT NULL REFERENCES genres(id) ON DELETE CASCADE,
    PRIMARY KEY (media_content_id, genre_id)
);

CREATE TABLE IF NOT EXISTS media_content_creatives (
    media_content_id UUID NOT NULL REFERENCES media_content(id) ON DELETE CASCADE,
    creative_id UUID NOT NULL REFERENCES creatives(creative_id) ON DELETE CASCADE,
    PRIMARY KEY (media_content_id, creative_id)
);

CREATE TABLE IF NOT EXISTS media_content_topics (
    media_content_id UUID NOT NULL REFERENCES media_content(id) ON DELETE CASCADE,
    topic_id UUID NOT NULL REFERENCES topics(id) ON DELETE CASCADE,
    PRIMARY KEY (media_content_id, topic_id)
);

CREATE TABLE IF NOT EXISTS recommendation_engine_tags (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    media_content_id UUID NOT NULL REFERENCES media_content(id) ON DELETE CASCADE,
    mood VARCHAR(100),
    pacing VARCHAR(100),
    audience_type VARCHAR(100),
    theme VARCHAR(100),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 9. Indexes bổ sung (tuỳ chọn)
CREATE INDEX IF NOT EXISTS idx_media_content_name ON media_content(name);
CREATE INDEX IF NOT EXISTS idx_media_content_year ON media_content(year);
CREATE INDEX IF NOT EXISTS idx_media_content_rating ON media_content(average_rating);
CREATE INDEX IF NOT EXISTS idx_movies_nation_id ON movies(nation_id);
CREATE INDEX IF NOT EXISTS idx_series_nation_id ON tv_series(nation_id);



-- -- Create views for common queries
-- CREATE OR REPLACE VIEW movie_details AS
-- SELECT 
--     m.id,
--     m.name,
--     m.year,
--     m.summary,
--     m.rating,
--     m.type,
--     n.name as country,
--     STRING_AGG(DISTINCT g.name, ', ') as genres,
--     STRING_AGG(DISTINCT CASE WHEN c.role = 'director' THEN c.name END, ', ') as directors,
--     STRING_AGG(DISTINCT CASE WHEN c.role = 'actor' THEN c.name END, ', ') as actors
-- FROM movies m
-- LEFT JOIN nations n ON m.nation_id = n.id
-- LEFT JOIN movie_genres mg ON m.id = mg.movie_id
-- LEFT JOIN genres g ON mg.genre_id = g.id
-- LEFT JOIN movie_creatives mc ON m.id = mc.movie_id
-- LEFT JOIN creatives c ON mc.creative_id = c.creative_id
-- GROUP BY m.id, m.name, m.year, m.summary, m.rating, m.type, n.name;

-- -- Create view for user statistics
-- CREATE OR REPLACE VIEW user_stats AS
-- SELECT 
--     up.profile_id,
--     up.profile_name,
--     COUNT(DISTINCT r.movie_id) as movies_rated,
--     AVG(r.rating) as average_rating_given,
--     COUNT(DISTINCT c.movie_id) as movies_commented,
--     COUNT(DISTINCT uim.movie_id) as movies_watched,
--     SUM(uim.watch_time_minutes) as total_watch_time_minutes
-- FROM user_profiles up
-- LEFT JOIN ratings r ON up.profile_id = r.user_profile_id
-- LEFT JOIN comments c ON up.profile_id = c.user_profile_id
-- LEFT JOIN user_interaction_metrics uim ON up.profile_id = uim.user_profile_id
-- GROUP BY up.profile_id, up.profile_name;