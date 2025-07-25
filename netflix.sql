CREATE TABLE netflix(
	show_id VARCHAR(6),
	type VARCHAR(8),
	title VARCHAR(105),
	director VARCHAR(208),
	casts VARCHAR(780),
	country VARCHAR(130),
	date_added VARCHAR(130),
	release_year INT,
	rating VARCHAR(10),
	duration VARCHAR(15),
	listed_in VARCHAR(85),
	description VARCHAR(255)
);

SELECT *
FROM netflix;

SELECT DISTINCT rating
FROM netflix;


---buisness problem

-- 1. Count the number of Movies vs TV Shows
-- 2. Find the most common rating for movies and TV shows
-- 3. List all movies released in a specific year (e.g., 2020)
-- 4. Find the top 5 countries with the most content on Netflix
-- 5. Identify the longest movie
-- 6. Find content added in the last 5 years
-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
-- 8. List all TV shows with more than 5 seasons
-- 9. Count the number of content items in each genre
-- 10.Find each year and the average numbers of content release in India on netflix. 
-- return top 5 year with highest avg content release!
-- 11. List all movies that are documentaries
-- 12. Find all content without a director
-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
-- 15.
-- Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
-- the description field. Label content containing these keywords as 'Bad' and all other 
-- content as 'Good'. Count how many items fall into each category.


-- 1. Count the number of Movies vs TV Shows
--Answer to the question no 1

SELECT 
	type,
	COUNT(*)
FROM netflix
GROUP BY 1;	
	

-- 2. Find the most common rating for movies and TV shows
-- Answer to the question no 2

SELECT 
	type,
	rating,
	count(*)
FROM netflix
GROUP BY 1,2
ORDER BY 3 DESC;

-- 3. List all movies released in a specific year (e.g., 2020)
--Answer to the question no 3

SELECT *
FROM netflix

SELECT 
	*
FROM 
	netflix
WHERE type='Movie' AND release_year ='2020'


-- 4. Find the top 5 countries with the most content on Netflix
--Answer to the question no 4

SELECT 
	DISTINCT country, COUNT(*)
FROM netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

----- 5. Identify the longest movie

SELECT 
	*
FROM netflix
WHERE type ='Movie'
	AND duration IS NOT NULL
ORDER BY SPLIT_PART(duration,' ',1)::INT DESC
LIMIT 1


-- 6. Find content added in the last 5 years
---Answer to the question no 6
SELECT
	*
FROM 
	netflix
WHERE 
	release_year::INT> EXTRACT(YEAR FROM CURRENT_DATE )-5
	

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

SELECT
	*
FROM
	netflix
WHERE 
	director= 'Rajiv Chilaka'

-- 8. List all TV shows with more than 5 seasons

SELECT
	type,
	duration
FROM 
	netflix
WHERE
	type = 'TV Show'
	AND SPLIT_PART(duration,' ',1)::INT >5;

-- 9. Count the number of content items in each genre

SELECT
	DISTINCT listed_in,
	COUNT(*)
FROM 
	netflix
GROUP BY 1
ORDER BY 2 DESC;

-- 10.Find each year and the average numbers of content release in India on netflix.


SELECT 
	release_year AS years_of_release,
	COUNT(*) AS toral_movie_release_in_india
FROM
	netflix
WHERE
	country='India'
GROUP BY 1;

-- return top 5 year with highest avg content release!

SELECT 
	release_year AS years_of_release,
	COUNT(*) AS toral_movie_release_in_india
FROM
	netflix
WHERE
	country='India'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


-- 11. List all movies that are documentaries
SELECT
	title AS all_the_movies_those_are_documentaries
FROM 
	netflix
WHERE
	type='Movie'
	AND listed_in = 'Documentaries'

-- 12. Find all content without a director
-- Ans to the question no 12
SELECT *
FROM netflix
WHERE director IS NULL;


-- 13. Find how many movies actor 'Salman Khan' appeared in last 20 years!
SELECT 
	*	
FROM
	netflix
WHERE 
	casts LIKE '%Salman Khan%'
	AND release_year::INT > EXTRACT(YEAR FROM CURRENT_DATE) - 20
	
-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

SELECT
	UNNEST(STRING_TO_ARRAY(casts,',')) AS actor,
	COUNT(*)
FROM netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10

-- 15.
-- Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
-- the description field. Label content containing these keywords as 'Bad' and all other 
-- content as 'Good'. Count how many items fall into each category.

SELECT 
	category,
	type,
	COUNT(*)
FROM(
	SELECT
		*,
		CASE
			WHEN description LIKE '%kill%' OR description LIKE '%violence' THEN 'Bad'
			ELSE 'Good'
		END AS category
	FROM 
		netflix)
GROUP BY 1,2
ORDER BY 3 DESC



-------------------------End Of The Project-------------------------------------



