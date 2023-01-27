-- 1. How many rows are in the names table?
SELECT COUNT(*) as name_count
FROM names;
-- There are 1957046 rows in names.

-- 2. How many total registered people appear in the dataset?
SELECT SUM(num_registered)
FROM names;
-- There are 351653025 total registered people.

-- 3. Which name had the most appearances in a single year in the dataset?
SELECT name, num_registered AS max_name
FROM names 
WHERE num_registered = (SELECT MAX(num_registered) FROM names );
-- The name Linda had the most instances in a single year.

-- 4. What range of years are included?
SELECT MIN(year), MAX(year)
FROM names;
-- The range of years is 1880-2018

-- 5. What year has the largest number of registrations?
SELECT
  year,
  SUM(num_registered) AS total
FROM names
GROUP BY year
ORDER BY total DESC;
-- 1957 had the largest number of registrations

-- 6. How many different (distinct) names are contained in the dataset?
SELECT COUNT(DISTINCT name) AS name_sum
FROM names;
-- There are 98400 distinct names in the dataset.

--  7. Are there more males or more females registered?
SELECT COUNT(gender) AS gen
FROM names
GROUP BY gender;
-- There are more registered females.

-- 8. What are the most popular male and female names overall (i.e., the most total registrations)?
SELECT
  gender,
  name,
  SUM(num_registered) AS total
FROM names
GROUP BY name, gender
ORDER BY total DESC;
-- James and Mary were the most popular names overall.

-- 9. What are the most popular boy and girl names of the first decade of the 2000s (2000 - 2009)?
SELECT name, sum(num_registered) AS total
FROM names 
WHERE year BETWEEN 2000 AND 2009
GROUP BY name
ORDER BY total DESC;
-- Jacob and Emily are the most popular boy and girl names between 2000-2009.

-- 10. Which year had the most variety in names (i.e. had the most distinct names)?
SELECT year, COUNT(DISTINCT name) AS distinct_names
FROM names
GROUP BY year
ORDER BY distinct_names DESC;
-- 2008 had the most distinct names.

-- 11. What is the most popular name for a girl that starts with the letter X?
SELECT name, gender, SUM(num_registered) AS x_name
FROM names
WHERE name LIKE 'X%' AND gender = 'F'
GROUP BY name, gender
ORDER BY x_name DESC;
-- Ximena is the most popular girl's name that starts with X

-- 12. How many distinct names appear that start with a 'Q', but whose second letter is not 'u'?
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

-- 13. Which is the more popular spelling between "Stephen" and "Steven"? Use a single query to answer this question.
SELECT name, SUM(num_registered) AS stevens
FROM names
WHERE name LIKE 'Stephen' OR name LIKE 'Steven'
GROUP BY name;
-- Steven is the more popular spelling.

-- 14. What percentage of names are "unisex" - that is what percentage of names have been used both for boys and for girls? 
SELECT name
FROM names
GROUP BY name
HAVING MIN(gender) <> MAX(gender);
--98400 total, 10773 are unisex. Close to 11% of names are unisex.