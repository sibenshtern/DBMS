CREATE TABLE LOG (
    id INTEGER PRIMARY KEY,
    user_id STRING,
    time DATE,
    bet INTEGER,
    win INTEGER
);

CREATE TABLE USER (
    id INTEGER PRIMARY KEY,
    user_id STRING,
    email VARCHAR(30),
    geo VARCHAR(30)
);

-- Задание восьмое

-- a
SELECT USER.user_id, COUNT(LOG.id) AS visits_before_bet
FROM USER
JOIN (
    SELECT user_id, MIN(time) AS first_bet_time
    FROM LOG
    WHERE bet <> 0
    GROUP BY user_id
) AS first_bet ON USER.user_id = first_bet.user_id
JOIN LOG ON USER.user_id = LOG.user_id AND LOG.time < first_bet.first_bet_time
GROUP BY USER.user_id;

-- b
SELECT AVG(win / bet) AS winning
FROM LOG
WHERE win != 0 AND bet != 0;

-- с
SELECT user_id, SUM(win) balance
FROM LOG
GROUP BY user_id
ORDER BY user_id DESC;

-- d
SELECT geo, SUM(win) winning
FROM USER JOIN LOG L on USER.user_id = L.user_id
GROUP BY geo;

-- f
SELECT USER.user_id, TIMEDIFF(first_bet_time, MIN(time)) TIME_TO_FIRST_BET
FROM USER
JOIN (
    SELECT user_id, MIN(time) AS first_bet_time
    FROM LOG
    WHERE bet <> 0
    GROUP BY user_id
) AS first_bet ON USER.user_id = first_bet.user_id
JOIN LOG ON USER.user_id = LOG.user_id AND LOG.time < first_bet.first_bet_time
GROUP BY USER.user_id
