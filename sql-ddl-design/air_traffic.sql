-- from the terminal run:
-- psql < air_traffic.sql

-- DROP DATABASE IF EXISTS air_traffic;

-- CREATE DATABASE air_traffic;

-- \c air_traffic

-- CREATE TABLE tickets
-- (
--   id SERIAL PRIMARY KEY,
--   first_name TEXT NOT NULL,
--   last_name TEXT NOT NULL,
--   seat TEXT NOT NULL,
--   departure TIMESTAMP NOT NULL,
--   arrival TIMESTAMP NOT NULL,
--   airline TEXT NOT NULL,
--   from_city TEXT NOT NULL,
--   from_country TEXT NOT NULL,
--   to_city TEXT NOT NULL,
--   to_country TEXT NOT NULL
-- );

-- INSERT INTO tickets
--   (first_name, last_name, seat, departure, arrival, airline, from_city, from_country, to_city, to_country)
-- VALUES
--   ('Jennifer', 'Finch', '33B', '2018-04-08 09:00:00', '2018-04-08 12:00:00', 'United', 'Washington DC', 'United States', 'Seattle', 'United States'),
--   ('Thadeus', 'Gathercoal', '8A', '2018-12-19 12:45:00', '2018-12-19 16:15:00', 'British Airways', 'Tokyo', 'Japan', 'London', 'United Kingdom'),
--   ('Sonja', 'Pauley', '12F', '2018-01-02 07:00:00', '2018-01-02 08:03:00', 'Delta', 'Los Angeles', 'United States', 'Las Vegas', 'United States'),
--   ('Jennifer', 'Finch', '20A', '2018-04-15 16:50:00', '2018-04-15 21:00:00', 'Delta', 'Seattle', 'United States', 'Mexico City', 'Mexico'),
--   ('Waneta', 'Skeleton', '23D', '2018-08-01 18:30:00', '2018-08-01 21:50:00', 'TUI Fly Belgium', 'Paris', 'France', 'Casablanca', 'Morocco'),
--   ('Thadeus', 'Gathercoal', '18C', '2018-10-31 01:15:00', '2018-10-31 12:55:00', 'Air China', 'Dubai', 'UAE', 'Beijing', 'China'),
--   ('Berkie', 'Wycliff', '9E', '2019-02-06 06:00:00', '2019-02-06 07:47:00', 'United', 'New York', 'United States', 'Charlotte', 'United States'),
--   ('Alvin', 'Leathes', '1A', '2018-12-22 14:42:00', '2018-12-22 15:56:00', 'American Airlines', 'Cedar Rapids', 'United States', 'Chicago', 'United States'),
--   ('Berkie', 'Wycliff', '32B', '2019-02-06 16:28:00', '2019-02-06 19:18:00', 'American Airlines', 'Charlotte', 'United States', 'New Orleans', 'United States'),
--   ('Cory', 'Squibbes', '10D', '2019-01-20 19:30:00', '2019-01-20 22:45:00', 'Avianca Brasil', 'Sao Paolo', 'Brazil', 'Santiago', 'Chile');

DROP DATABASE IF EXISTS air_traffic_changed;
CREATE DATABASE air_traffic_changed;
\c air_traffic_changed;

-- ******DDL*******

-- Airlines
CREATE TABLE airlines (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    code TEXT NOT NULL UNIQUE
);

-- Airports
CREATE TABLE airports (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    city TEXT,
    country TEXT,
    code TEXT NOT NULL UNIQUE
);

-- Flights
CREATE TABLE flights (
    id SERIAL PRIMARY KEY,
    airline_id INTEGER REFERENCES airlines(id),
    origin_airport_id INTEGER REFERENCES airports(id),
    destination_airport_id INTEGER REFERENCES airports(id),
    departure_time TIMESTAMP,
    arrival_time TIMESTAMP
);

-- Passengers
CREATE TABLE passengers (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    passport_number TEXT UNIQUE
);

-- Bookings
CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    flight_id INTEGER REFERENCES flights(id),
    passenger_id INTEGER REFERENCES passengers(id),
    seat_number TEXT
);

-- ******INSERT DATA*******

-- Airlines
INSERT INTO airlines (name, code) VALUES
    ('Global Air', 'GA'),
    ('SkyFly', 'SF');

-- Airports
INSERT INTO airports (name, city, country, code) VALUES
    ('JFK International', 'New York', 'USA', 'JFK'),
    ('Heathrow', 'London', 'UK', 'LHR'),
    ('Haneda', 'Tokyo', 'Japan', 'HND');

-- Flights
INSERT INTO flights (airline_id, origin_airport_id, destination_airport_id, departure_time, arrival_time) VALUES
    (1, 1, 2, '2024-06-01 08:00', '2024-06-01 20:00'),
    (2, 2, 3, '2024-06-05 10:30', '2024-06-06 06:15');

-- Passengers
INSERT INTO passengers (name, passport_number) VALUES
    ('Sophia Clark', 'X1234567'),
    ('David Rivera', 'Y9876543');

-- Bookings
INSERT INTO bookings (flight_id, passenger_id, seat_number) VALUES
    (1, 1, '12A'),
    (1, 2, '14C'),
    (2, 1, '10B');

-- ******TEST QUERIES******

-- Show flights with airline and airport info
SELECT 
    f.id AS flight_id,
    a.name AS airline,
    oa.code AS origin,
    da.code AS destination,
    f.departure_time,
    f.arrival_time
FROM flights f
JOIN airlines a ON f.airline_id = a.id
JOIN airports oa ON f.origin_airport_id = oa.id
JOIN airports da ON f.destination_airport_id = da.id;

-- Show passengers on Flight 1
SELECT 
    p.name AS passenger,
    b.seat_number
FROM bookings b
JOIN passengers p ON b.passenger_id = p.id
WHERE b.flight_id = 1;

-- Count bookings per flight
SELECT 
    f.id AS flight_id,
    COUNT(b.id) AS total_passengers
FROM flights f
LEFT JOIN bookings b ON f.id = b.flight_id
GROUP BY f.id;