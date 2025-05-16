-- Get all posts with user and region info
SELECT 
    p.title,
    u.username,
    r.name AS region,
    p.location
FROM posts p
JOIN users u ON p.user_id = u.id
JOIN regions r ON p.region_id = r.id;

-- List all posts in the 'Jobs' category
SELECT 
    p.title,
    p.content
FROM posts p
JOIN post_categories pc ON p.id = pc.post_id
JOIN categories c ON pc.category_id = c.id
WHERE c.name = 'Jobs';

-- Show each user's preferred region
SELECT 
    u.username,
    r.name AS preferred_region
FROM users u
JOIN regions r ON u.preferred_region_id = r.id;

-- Count number of posts per category
SELECT 
    c.name AS category,
    COUNT(pc.post_id) AS post_count
FROM categories c
LEFT JOIN post_categories pc ON c.id = pc.category_id
GROUP BY c.name;