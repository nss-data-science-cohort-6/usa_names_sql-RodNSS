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
SELECT COUNT(DISTINCT name) AS distinct_names
FROM names
WHERE name LIKE 'Q%' AND name NOT LIKE 'Qu%';
-- There are 46 names that start with Q but not Qu.

-- 13. Which is the more popular spelling between "Stephen" and "Steven"? Use a single query to answer this question.
SELECT name, SUM(num_registered) AS stevens
FROM names
WHERE name LIKE 'Stephen' OR name LIKE 'Steven'
GROUP BY name;
-- Steven is the more popular spelling.

-- 14. What percentage of names are "unisex" - that is what percentage of names have been used both for boys and for girls? 
SELECT COUNT(name)
FROM names
GROUP BY name
HAVING MIN(gender) <> MAX(gender);
--98400 total, 10773 are unisex. Close to 11% of names are unisex.

-- 15. How many names have made an appearance in every single year since 1880?
SELECT name,COUNT(DISTINCT year) AS distinct_year
FROM names
GROUP BY name
HAVING COUNT(DISTINCT year)=139;
-- There are 921 names that appeared every single year.

-- 16. How many names have only appeared in one year?
SELECT name,COUNT(DISTINCT year) AS distinct_year
FROM names
GROUP BY name
HAVING COUNT(DISTINCT year)=1;
-- 21,123 names have appeared in only one year.

-- 17. How many names only appeared in the 1950s?
SELECT name
FROM names
GROUP BY name
HAVING MIN(year) >= 1950 AND MAX(year) <= 1959;
-- 661 names appeared only in the fifties.

-- 18. How many names made their first appearance in the 2010s?
SELECT name
FROM names
GROUP BY name
HAVING MIN(year) >= 2010;
-- 11,270 names first appeared in the 2010s.

-- 19. Find the names that have not be used in the longest.
SELECT name, MAX(year)
FROM names
GROUP BY name
ORDER BY MAX(year);
-- Zilpah and Roll have not been used since 1881.

-- 20. Come up with a question that you would like to answer using this dataset. Then write a query to answer this question.
-- Question: What are the total names per year, separated by gender?
SELECT gender, year, COUNT(name) as total_names
FROM names
WHERE year >= 1880
GROUP BY gender, year
ORDER BY year, gender;

-- Bonus questions:

-- 1. Find the longest name contained in this dataset. What do you notice about the long names?
SELECT name, LENGTH(name) as long_names
FROM names
ORDER BY long_names DESC
LIMIT 10;
-- The top longest names all have 15 letters.

-- 2. How many names are palindromes (i.e. read the same backwards and forwards, such as Bob and Elle)?
SELECT COUNT(DISTINCT name)
FROM names
WHERE LOWER(name) = REVERSE(LOWER(name));
-- There are 137 palindromes in the dataset.

-- 3. Find all names that contain no vowels (for this question, we'll count a,e,i,o,u, and y as vowels).
SELECT DISTINCT(name)
FROM names
WHERE name !~* '[aeiouy]';
-- 43 names total

-- 4. How many double-letter names show up in the dataset? Double-letter means the same letter repeated back-to-back, like Matthew or Aaron. Are there any triple-letter names?
SELECT COUNT(DISTINCT name)
FROM names
WHERE name ~* '(.)\1';
-- There are 22,537 names with double letters.

SELECT COUNT(DISTINCT name)
FROM names
WHERE name ~* '(.)\1\1';
-- There are 12 names with triple letters.