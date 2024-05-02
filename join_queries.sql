-- Первое задание
SELECT ShipCountry, SUM(UnitPrice * Quantity) AS TotalSum
FROM sales
         JOIN sales_items on sales.SalesId = sales_items.SalesId
WHERE ShipCountry = 'USA'
  AND SalesDate >= DATE('2012-01-01')
  AND SalesDate < DATE('2012-04-01');

SELECT ShipCountry,
       SUM(IFNULL((SELECT SUM(UnitPrice * Quantity)
                   FROM sales_items
                   WHERE sales_items.SalesId = sales.SalesId
                     AND SalesDate >= DATE('2012-01-01')
                     AND SalesDate < DATE('2012-04-01')), 0)) As TotalSum
FROM sales
WHERE ShipCountry = 'USA';

-- Второе задание
SELECT DISTINCT FirstName
FROM customers
WHERE FirstName NOT IN (SELECT FirstName FROM employees)
ORDER BY FirstName;

SELECT FirstName
FROM customers
EXCEPT
SELECT FirstName
from employees
ORDER BY FirstName;

SELECT DISTINCT customers.FirstName
FROM customers
         JOIN employees on customers.SupportRepId = employees.EmployeeId
WHERE customers.FirstName != employees.FirstName
ORDER BY customers.FirstName;

-- Третье задание
-- Запросы выдадут одинаковый ответ, насколько я понял, разницы между ними в этой случае нет

-- Четвертое задание
SELECT a.Title AS AlbumTitle, COUNT(t.TrackId) AS TracksCount
FROM albums AS a
         JOIN tracks t on a.AlbumId = t.AlbumId
GROUP BY AlbumTitle;

SELECT a.Title as AlbumTitle, (SELECT COUNT(*) FROM tracks WHERE tracks.AlbumId = a.AlbumID) AS TracksCount
FROM albums as a;

-- Пятое задание
SELECT DISTINCT c.LastName, c.FirstName
FROM customers AS c
         JOIN sales s on c.CustomerId = s.CustomerId
WHERE ShipCity = 'Berlin'
  AND c.Country = 'Germany'
  AND STRFTIME('%Y', SalesDate) = '2009';

-- Шестое задание
SELECT c.LastName, COUNT(c.CustomerId) AS SalesCount
FROM customers c
         JOIN sales s on c.CustomerId = s.CustomerId
GROUP BY c.CustomerId;

SELECT c.LastName, (SELECT COUNT(s.SalesId) FROM sales s WHERE CustomerId = c.CustomerId) AS SalesCount
FROM customers c
ORDER BY c.CustomerId;

-- Седьмое задание
SELECT g.Name, (SELECT AVG(t.UnitPrice) FROM tracks t WHERE t.GenreId = g.GenreId) AS AveragePrice
FROM genres g
ORDER BY g.Name;

SELECT g.Name, AVG(t.UnitPrice)
FROM genres g
         JOIN tracks t on g.GenreId = t.GenreId
GROUP BY g.Name
ORDER BY g.Name;

-- Восьмое задание
SELECT g.Name
FROM genres g
         JOIN tracks t on g.GenreId = t.GenreId
GROUP BY g.Name
HAVING AVG(t.UnitPrice) > 1
ORDER BY g.Name;
