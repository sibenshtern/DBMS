import sqlite3
import csv

with open('log (1).csv', 'r', encoding='utf-8') as log_file:
    reader = csv.reader(log_file, delimiter=',')
    with sqlite3.connect('hard.s3db') as connection:
        for line in reader:
            user_id, time, bet, win = line
            connection.execute(
                "INSERT INTO LOG (user_id, time, bet, win) VALUES (?, ?, ?, ?)",
                (user_id, time, bet, win))
            connection.commit()


with open('users (1).csv', 'r', encoding='KOI8-R') as users_file:
    reader = csv.reader(users_file, delimiter='\t')
    with sqlite3.connect('hard.s3db') as connection:
        for index, line in enumerate(reader):
            if index == 0:
                continue

            user_id, email, geo = line
            connection.execute(
                "INSERT INTO USER (user_id, email, geo) VALUES (?, ?, ?)",
                (user_id, email, geo)
            )
        connection.commit()

