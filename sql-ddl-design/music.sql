-- from the terminal run:
-- psql < music.sql

-- DROP DATABASE IF EXISTS music;

-- CREATE DATABASE music;

-- \c music

-- CREATE TABLE songs
-- (
--   id SERIAL PRIMARY KEY,
--   title TEXT NOT NULL,
--   duration_in_seconds INTEGER NOT NULL,
--   release_date DATE NOT NULL,
--   artists TEXT[] NOT NULL,
--   album TEXT NOT NULL,
--   producers TEXT[] NOT NULL
-- );

-- INSERT INTO songs
--   (title, duration_in_seconds, release_date, artists, album, producers)
-- VALUES
--   ('MMMBop', 238, '04-15-1997', '{"Hanson"}', 'Middle of Nowhere', '{"Dust Brothers", "Stephen Lironi"}'),
--   ('Bohemian Rhapsody', 355, '10-31-1975', '{"Queen"}', 'A Night at the Opera', '{"Roy Thomas Baker"}'),
--   ('One Sweet Day', 282, '11-14-1995', '{"Mariah Cary", "Boyz II Men"}', 'Daydream', '{"Walter Afanasieff"}'),
--   ('Shallow', 216, '09-27-2018', '{"Lady Gaga", "Bradley Cooper"}', 'A Star Is Born', '{"Benjamin Rice"}'),
--   ('How You Remind Me', 223, '08-21-2001', '{"Nickelback"}', 'Silver Side Up', '{"Rick Parashar"}'),
--   ('New York State of Mind', 276, '10-20-2009', '{"Jay Z", "Alicia Keys"}', 'The Blueprint 3', '{"Al Shux"}'),
--   ('Dark Horse', 215, '12-17-2013', '{"Katy Perry", "Juicy J"}', 'Prism', '{"Max Martin", "Cirkut"}'),
--   ('Moves Like Jagger', 201, '06-21-2011', '{"Maroon 5", "Christina Aguilera"}', 'Hands All Over', '{"Shellback", "Benny Blanco"}'),
--   ('Complicated', 244, '05-14-2002', '{"Avril Lavigne"}', 'Let Go', '{"The Matrix"}'),
--   ('Say My Name', 240, '11-07-1999', '{"Destiny''s Child"}', 'The Writing''s on the Wall', '{"Darkchild"}');

DROP DATABASE IF EXISTS music_changed;
CREATE DATABASE music_changed;
\c music_changed;

-- ******DDL******

-- Artists
CREATE TABLE artists (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

-- Albums
CREATE TABLE albums (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    artist_id INTEGER REFERENCES artists(id),
    release_year INTEGER
);

-- Songs
CREATE TABLE songs (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    album_id INTEGER REFERENCES albums(id),
    duration INTEGER  -- seconds
);

-- Playlists
CREATE TABLE playlists (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

-- Playlist -> Songs
CREATE TABLE playlist_songs (
    playlist_id INTEGER REFERENCES playlists(id),
    song_id INTEGER REFERENCES songs(id),
    position INTEGER,
    PRIMARY KEY (playlist_id, song_id)
);

-- ******INSERT DATA*******

-- Artists
INSERT INTO artists (name) VALUES
    ('The Riverstones'),
    ('Neon Echo');

-- Albums
INSERT INTO albums (title, artist_id, release_year) VALUES
    ('Flowing Forward', 1, 2022),
    ('Bright Nights', 2, 2023);

-- Songs
INSERT INTO songs (title, album_id, duration) VALUES
    ('Morning Tide', 1, 210),
    ('Stone Steps', 1, 185),
    ('City Lights', 2, 200),
    ('Reflections', 2, 240);

-- Playlists
INSERT INTO playlists (name) VALUES
    ('Workout Mix'),
    ('Chill Vibes');

-- Playlist -> Songs
INSERT INTO playlist_songs (playlist_id, song_id, position) VALUES
    (1, 1, 1),
    (1, 3, 2),
    (2, 2, 1),
    (2, 4, 2);

-- ******TEST QUERIES*******

-- List songs with album and artist
SELECT 
    s.title AS song,
    al.title AS album,
    ar.name AS artist
FROM songs s
JOIN albums al ON s.album_id = al.id
JOIN artists ar ON al.artist_id = ar.id;

-- List songs in 'Workout Mix' playlist
SELECT 
    ps.position,
    s.title AS song
FROM playlist_songs ps
JOIN playlists pl ON ps.playlist_id = pl.id
JOIN songs s ON ps.song_id = s.id
WHERE pl.name = 'Workout Mix'
ORDER BY ps.position;

-- Count songs per album
SELECT 
    al.title AS album,
    COUNT(s.id) AS total_songs
FROM albums al
LEFT JOIN songs s ON al.id = s.album_id
GROUP BY al.title;