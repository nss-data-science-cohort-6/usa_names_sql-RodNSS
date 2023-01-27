SELECT COUNT(*) as name_count
FROM names;
-- There are 1957046 rows in names.

SELECT SUM(num_registered)
FROM names;
-- There are 351653025 total registered people.

SELECT name, num_registered AS max_name
FROM names 
WHERE num_registered = (SELECT MAX(num_registered) FROM names );
-- The name Linda had the most instances in a single year.

SELECT MIN(year), MAX(year)
FROM names;
-- The range of years is 1880-2018

SELECT
  year,
  SUM(num_registered) AS total
FROM names
GROUP BY year
ORDER BY total DESC;
-- 1957 had the largest number of registrations

SELECT COUNT(DISTINCT name) AS name_sum
FROM names;
-- There are 98400 distinct names in the dataset.

SELECT COUNT(gender) AS gen
FROM names
GROUP BY gender;
-- There are more registered females.

SELECT
  gender,
  name,
  SUM(num_registered) AS total
FROM names
GROUP BY name, gender
ORDER BY total DESC;
-- James and Mary were the most popular names overall.

SELECT name, sum(num_registered) AS total
FROM names 
WHERE year BETWEEN 2000 AND 2009
GROUP BY name
ORDER BY total DESC;
-- Jacob and Emily are the most popular boy and girl names between 2000-2009.

SELECT year, COUNT(DISTINCT name) AS distinct_names
FROM names
GROUP BY year
ORDER BY distinct_names DESC;
-- 2008 had the most distinct names.

SELECT name, gender, SUM(num_registered) AS x_name
FROM names
WHERE name LIKE 'X%' AND gender = 'F'
GROUP BY name, gender
ORDER BY x_name DESC;
-- Ximena is the most popular girl's name that starts with X

SELECT name, COUNT(DISTINCT name) AS distinct_names
FROM names
WHERE name LIKE 'Q%' 
GROUP BY name
ORDER BY distinct_names DESC;

SELECT name, COUNT(DISTINCT name) AS distinct_names
FROM names
WHERE name LIKE 'Qu%' 
GROUP BY name
ORDER BY distinct_names DESC;
-- 537-491 = 46 names that start with Q but not Qu.

SELECT name, COUNT(name) AS stevens
FROM names
WHERE name LIKE 'Stephen' OR name LIKE 'Steven'
GROUP BY name;
-- Stephen is the more popular spelling

SELECT name
FROM names
GROUP BY name
HAVING MIN(gender) <> MAX(gender);
--98400 total, 10773 are unisex. Close to 11% of names are unisex.