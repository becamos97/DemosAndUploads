-- Show all players and the team they play for
SELECT p.name AS player, t.name AS team
FROM players p
JOIN teams t ON p.team_id = t.id;

-- List all matches and final score (total goals per team)
SELECT
    m.id AS match_id,
    ht.name AS home_team,
    at.name AS away_team,
    m.match_date,
    SUM(CASE WHEN p.team_id = m.home_team_id THEN 1 ELSE 0 END) AS home_goals,
    SUM(CASE WHEN p.team_id = m.away_team_id THEN 1 ELSE 0 END) AS away_goals
FROM matches m
LEFT JOIN goals g ON g.match_id = m.id
LEFT JOIN players p ON g.player_id = p.id
JOIN teams ht ON m.home_team_id = ht.id
JOIN teams at ON m.away_team_id = at.id
GROUP BY m.id, ht.name, at.name, m.match_date;

-- List all goals with player name and minute
SELECT
    g.goal_time,
    p.name AS player,
    t.name AS team,
    m.match_date
FROM goals g
JOIN players p ON g.player_id = p.id
JOIN teams t ON p.team_id = t.id
JOIN matches m ON g.match_id = m.id
ORDER BY m.match_date, g.goal_time;

-- List all referees per match
SELECT
    m.id AS match_id,
    r.name AS referee
FROM match_referees mr
JOIN matches m ON mr.match_id = m.id
JOIN referees r ON mr.referee_id = r.id
ORDER BY m.id;
