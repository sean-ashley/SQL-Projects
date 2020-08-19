-- This is the first query:
-- What are all the unique years in the dataset?
SELECT DISTINCT year from population_years;

-- Add your additional queries below:
-- When was the height of population in Gabon
SELECT country FROM population_years WHERE country = 'Gabon' ORDER BY population DESC LIMIT 1;

-- 10 lowest population countries in 2005
SELECT * FROM population_years WHERE year = 2005 ORDER BY population LIMIT 10;

--What are all the distinct countries with a population of over 100 million in the year 2010?
SELECT DISTINCT country FROM population_years WHERE year = 2010 and population > 100 ;

-- How many countries in this dataset have the word “Islands” in their name?
SELECT DISTINCT country FROM population_years WHERE country LIKE '%Islands%';
-- There are 9

SELECT * FROM population_years WHERE (year = 2000 or year = 2010) and country = 'Indonesia';

--population difference is 28.92 million.