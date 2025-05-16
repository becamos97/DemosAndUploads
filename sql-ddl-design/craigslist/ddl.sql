-- Regions
CREATE TABLE regions (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

-- Users
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username TEXT NOT NULL UNIQUE,
    preferred_region_id INTEGER REFERENCES regions(id)
);

-- Posts
CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    content TEXT,
    user_id INTEGER NOT NULL REFERENCES users(id),
    location TEXT,
    region_id INTEGER NOT NULL REFERENCES regions(id)
);

-- Categories
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

-- Join table: Posts ↔ Categories
CREATE TABLE post_categories (
    post_id INTEGER NOT NULL REFERENCES posts(id),
    category_id INTEGER NOT NULL REFERENCES categories(id),
    PRIMARY KEY (post_id, category_id)
);
