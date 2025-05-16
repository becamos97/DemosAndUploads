-- Seasons
INSERT INTO seasons (start_date, end_date) VALUES
    ('2023-08-01', '2024-05-20');

-- Teams
INSERT INTO teams (name) VALUES
    ('Lakeside FC'),
    ('Metro United');

-- Players
INSERT INTO players (name, team_id) VALUES
    ('Evan Brooks', 1),
    ('Luis Gomez', 1),
    ('Noah Chen', 2),
    ('Marco Silva', 2);

-- Matches
INSERT INTO matches (home_team_id, away_team_id, season_id, match_date) VALUES
    (1, 2, 1, '2023-09-15'),
    (2, 1, 1, '2023-11-10');

-- Referees
INSERT INTO referees (name) VALUES
    ('Jamie Stone'),
    ('Priya Nair');

-- Match ↔ Referee
INSERT INTO match_referees (match_id, referee_id) VALUES
    (1, 1),
    (1, 2),
    (2, 2);

-- Goals
INSERT INTO goals (match_id, player_id, goal_time) VALUES
    (1, 1, 34),  -- Evan Brooks, min 34
    (1, 3, 58),  -- Noah Chen, min 58
    (2, 4, 21);  -- Marco Silva, min 21