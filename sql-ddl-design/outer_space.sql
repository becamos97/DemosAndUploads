-- -- from the terminal run:
-- -- psql < outer_space.sql

-- DROP DATABASE IF EXISTS outer_space;

-- CREATE DATABASE outer_space;

-- \c outer_space

-- CREATE TABLE planets
-- (
--   id SERIAL PRIMARY KEY,
--   name TEXT NOT NULL,
--   orbital_period_in_years FLOAT NOT NULL,
--   orbits_around TEXT NOT NULL,
--   galaxy TEXT NOT NULL,
--   moons TEXT[]
-- );

-- INSERT INTO planets
--   (name, orbital_period_in_years, orbits_around, galaxy, moons)
-- VALUES
--   ('Earth', 1.00, 'The Sun', 'Milky Way', '{"The Moon"}'),
--   ('Mars', 1.88, 'The Sun', 'Milky Way', '{"Phobos", "Deimos"}'),
--   ('Venus', 0.62, 'The Sun', 'Milky Way', '{}'),
--   ('Neptune', 164.8, 'The Sun', 'Milky Way', '{"Naiad", "Thalassa", "Despina", "Galatea", "Larissa", "S/2004 N 1", "Proteus", "Triton", "Nereid", "Halimede", "Sao", "Laomedeia", "Psamathe", "Neso"}'),
--   ('Proxima Centauri b', 0.03, 'Proxima Centauri', 'Milky Way', '{}'),
--   ('Gliese 876 b', 0.23, 'Gliese 876', 'Milky Way', '{}');

-- DIVIDED THE CODING, BUT I COULD DO EACH SECTION AND INDIVIDUAL FILE
-- BUT KEPT IT IN ONE FILE FOR SIMPLICITY SAKES
DROP DATABASE IF EXISTS outer_space_changed;
CREATE DATABASE outer_space_changed;
\c outer_space_changed;

-- *****DDL*****

-- Stars table
CREATE TABLE stars (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    type TEXT
);

-- Planets table
CREATE TABLE planets (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    star_id INTEGER REFERENCES stars(id),
    planet_type TEXT
);

-- Moons table
CREATE TABLE moons (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    planet_id INTEGER REFERENCES planets(id)
);

-- Missions table
CREATE TABLE missions (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    target_planet_id INTEGER REFERENCES planets(id),
    launch_date DATE
);

-- ******INSERT DATA******

-- Stars
INSERT INTO stars (name, type) VALUES 
    ('Sun', 'G-type main-sequence'),
    ('Alpha Centauri A', 'G-type main-sequence');

-- Planets
INSERT INTO planets (name, star_id, planet_type) VALUES
    ('Earth', 1, 'Terrestrial'),
    ('Mars', 1, 'Terrestrial'),
    ('Proxima b', 2, 'Exoplanet');

-- Moons
INSERT INTO moons (name, planet_id) VALUES
    ('Moon', 1),
    ('Phobos', 2),
    ('Deimos', 2);

-- Missions
INSERT INTO missions (name, target_planet_id, launch_date) VALUES
    ('Apollo 11', 1, '1969-07-16'),
    ('Mars Pathfinder', 2, '1996-12-04');

-- ******TEST QUERIES*****

-- Show planets with their star
SELECT p.name AS planet, s.name AS star
FROM planets p
JOIN stars s ON p.star_id = s.id;

-- Show moons with their planet
SELECT m.name AS moon, p.name AS planet
FROM moons m
JOIN planets p ON m.planet_id = p.id;

-- Show missions and their target planets
SELECT ms.name AS mission, p.name AS target_planet, ms.launch_date
FROM missions ms
JOIN planets p ON ms.target_planet_id = p.id;