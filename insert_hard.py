import sqlite3
import csv


def process_log_line(line):
    user_id, date, bet, win = line
    user_id = user_id.split('-')[-1].strip()
    if user_id.startswith('#error'):
        return None

    date = date[1:] if date.startswith('[') else date
    bet = 0 if bet == '' else bet
    win = 0 if win == '' else win
    return user_id, date, bet, win


def process_user_line(line):
    user_id, email, geo = line
    user_id = user_id.lower()
    return user_id, email, geo


with open('log(1).csv', 'r', encoding='utf-8') as log_file:
    reader = csv.reader(log_file, delimiter=',')
    with sqlite3.connect('hard.s3db') as connection:
        for line in reader:
            result = process_log_line(line)
            if result is None:
                continue

            user_id, time, bet, win = result
            connection.execute(
                "INSERT INTO LOG (user_id, time, bet, win) VALUES (?, ?, ?, ?)",
                (user_id, time, bet, win))
        connection.commit()


with open('users(1).csv', 'r', encoding='KOI8-R') as users_file:
    reader = csv.reader(users_file, delimiter='\t')
    with sqlite3.connect('hard.s3db') as connection:
        for index, line in enumerate(reader):
            if index == 0:
                continue

            user_id, email, geo = process_user_line(line)
            connection.execute(
                "INSERT INTO USER (user_id, email, geo) VALUES (?, ?, ?)",
                (user_id, email, geo)
            )
        connection.commit()

