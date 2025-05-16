-- Regions
INSERT INTO regions (name) VALUES 
    ('San Francisco'), ('Atlanta'), ('Seattle');

-- Users
INSERT INTO users (username, preferred_region_id) VALUES 
    ('jdoe', 1),
    ('emtran', 2),
    ('markk', 3);

-- Categories
INSERT INTO categories (name) VALUES 
    ('Housing'), ('Jobs'), ('For Sale'), ('Community');

-- Posts
INSERT INTO posts (title, content, user_id, location, region_id) VALUES 
    ('2BR Apartment in Mission', 'Nice apartment, $3200/mo', 1, 'Mission District', 1),
    ('Software Engineer Needed', 'Great startup in downtown ATL', 2, 'Downtown', 2),
    ('Bike for Sale', 'Almost new, $300', 3, 'Capitol Hill', 3);

-- Post / Categories
INSERT INTO post_categories (post_id, category_id) VALUES 
    (1, 1),  -- Apartment -> Housing
    (2, 2),  -- Job post
    (3, 3);  -- Bike for Sale