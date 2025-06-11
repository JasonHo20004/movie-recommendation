-- Create movies table
CREATE TABLE IF NOT EXISTS movies (
    id SERIAL PRIMARY KEY,
    tmdb_id INTEGER,
    title VARCHAR(255),
    overview TEXT,
    poster_path VARCHAR(255),
    release_date DATE,
    vote_average NUMERIC,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create ratings table
CREATE TABLE IF NOT EXISTS ratings (
    id SERIAL PRIMARY KEY,
    movie_id INTEGER REFERENCES movies(id),
    user_id INTEGER,
    rating NUMERIC,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
); 