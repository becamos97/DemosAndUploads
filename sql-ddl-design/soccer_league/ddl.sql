-- Seasons
CREATE TABLE seasons (
    id SERIAL PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);

-- Teams
CREATE TABLE teams (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

-- Players
CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    team_id INTEGER REFERENCES teams(id)
);

-- Matches
CREATE TABLE matches (
    id SERIAL PRIMARY KEY,
    home_team_id INTEGER REFERENCES teams(id),
    away_team_id INTEGER REFERENCES teams(id),
    season_id INTEGER REFERENCES seasons(id),
    match_date DATE NOT NULL
);

-- Referees
CREATE TABLE referees (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

-- Match ↔ Referee (many-to-many)
CREATE TABLE match_referees (
    match_id INTEGER REFERENCES matches(id),
    referee_id INTEGER REFERENCES referees(id),
    PRIMARY KEY (match_id, referee_id)
);

-- Goals
CREATE TABLE goals (
    id SERIAL PRIMARY KEY,
    match_id INTEGER REFERENCES matches(id),
    player_id INTEGER REFERENCES players(id),
    goal_time INTEGER -- minute of match
);