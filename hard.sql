CREATE TABLE LOG
(
    id      INTEGER PRIMARY KEY,
    user_id STRING,
    time    DATE,
    bet     INTEGER,
    win     INTEGER
);

CREATE TABLE USER
(
    id      INTEGER PRIMARY KEY,
    user_id STRING,
    email   VARCHAR(30),
    geo     VARCHAR(30)
);

-- Чистка таблиц
DELETE FROM LOG WHERE user_id = '#error' OR user_id IS NULL;
UPDATE LOG SET user_id = TRIM(SUBSTR(TRIM(user_id), INSTR(user_id, 'user_')));
UPDATE LOG SET time = DATETIME(TRIM(time, '['));
UPDATE LOG SET bet = IIF(bet = '', 0, bet);
UPDATE LOG SET win = IIF(win = '', 0, win);

UPDATE USER SET user_id = REPLACE(user_id, 'User', 'user');
-- Задание восьмое

-- a
SELECT USER.user_id, COALESCE(COUNT(LOG.id), 0) AS visits_before_bet
FROM USER
         LEFT JOIN (SELECT user_id, MIN(time) AS first_bet_time
                    FROM LOG
                    WHERE bet <> 0
                    GROUP BY user_id) AS first_bet
                   ON USER.user_id = first_bet.user_id
         LEFT JOIN LOG ON USER.user_id = LOG.user_id AND
                          LOG.time < first_bet.first_bet_time
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
SELECT geo, SUM(win)
FROM USER JOIN LOG L on USER.user_id = L.user_id
GROUP BY geo;

-- f у меня не сработали STRFTIME и прочие функции. Я понимаю, что все, что мне осталось сделать, это вычесть две даты и взять условный AVG но у меня не получилось это сделать
SELECT USER.user_id, first_bet_time, MIN(time)
FROM USER
         JOIN (SELECT user_id, MIN(time) AS first_bet_time
               FROM LOG
               WHERE bet <> 0
               GROUP BY user_id) AS first_bet
              ON USER.user_id = first_bet.user_id
         JOIN LOG ON USER.user_id = LOG.user_id
GROUP BY USER.user_id;

-- Вот как должно было бы получится, но не уверен, что это выдает правильный ответ. Считает он среднее в днях
SELECT AVG(CAST(STRFTIME('%s', first_bet_time) AS INT) -
           CAST(STRFTIME('%s', min_time) AS INT)) / 60 / 60 /
       24 AS days_before_bet
FROM (SELECT first_bet_time, MIN(time) AS min_time
      FROM USER
               JOIN (SELECT user_id, MIN(time) AS first_bet_time
                     FROM LOG
                     WHERE bet <> 0
                     GROUP BY user_id) AS first_bet
                    ON USER.user_id = first_bet.user_id
               JOIN LOG ON USER.user_id = LOG.user_id)

