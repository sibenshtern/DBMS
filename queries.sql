-- Задание 1
SELECT FirstName, LastName
FROM customers
WHERE City = 'Prague';

-- Задание 2
SELECT FirstName, LastName
FROM customers
WHERE FirstName LIKE 'M%';

SELECT FirstName, LastName
FROM customers
WHERE FirstName LIKE '%ch%';

SELECT FirstName, LastName
FROM customers
WHERE FirstName LIKE 'M%ch%';

-- Задание 3
SELECT Name, Bytes / (1024 * 1024) AS Megabytes
FROM tracks;

-- Задание 4
SELECT FirstName, LastName
FROM employees
WHERE City == 'Calgary'
  AND STRFTIME('%Y', HireDate) == '2002';

-- Задание 5
SELECT FirstName, LastName
FROM employees
WHERE HireDate - BirthDate >= 40;

-- Задание 6
SELECT FirstName, LastName
FROM customers
WHERE Country == 'USA'
  AND IFNULL(Fax, FALSE);

-- Задание 7
SELECT ShipCity
FROM sales
WHERE ShipCountry == 'Canada'
  AND STRFTIME('%m', SalesDate) in ('08', '09');

-- Задание 8
SELECT Email
FROM customers
WHERE Email LIKE '%gmail.com';

-- Задание 9
SELECT FirstName || ' ' || LastName AS Name
FROM employees
WHERE DATE('now') - HireDate >= 18;

-- Задание 10
SELECT Title
FROM employees
ORDER BY Title;

SELECT DISTINCT Title
FROM employees
ORDER BY Title;

-- Задание 11
SELECT FirstName, LastName, STRFTIME('%Y', DATE('now', '-' || Age || ' year')) AS BirthYear
FROM customers
ORDER BY FirstName, LastName, BirthYear;

-- Задание 12
SELECT MIN(Milliseconds) / 1000 AS Seconds
FROM tracks;

-- Задание 13
SELECT Name, MIN(Milliseconds) / 1000 As Seconds
FROM tracks;

-- Задание 14
SELECT Country, AVG(Age)
FROM customers
GROUP BY Country;

-- Задание 15
SELECT LastName
FROM employees
WHERE STRFTIME('%m', HireDate) == '10';

-- Задание 16
SELECT LastName
FROM employees ORDER BY HireDate LIMIT 1;

