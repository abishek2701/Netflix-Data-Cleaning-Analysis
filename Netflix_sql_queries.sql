   CREATE DATABASE netflix_db;
   USE netflix_db;

-- Netflix Data Cleaning & Analysis — SQL Business Questions

-- Q1. How many total titles are on Netflix, split by Movie vs TV Show?
SELECT type, COUNT(*) AS total_titles
FROM netflix
GROUP BY type;

-- Q2. How many titles were added to Netflix each year?
SELECT YEAR(date_added) AS year_added, COUNT(*) AS titles_added
FROM netflix
GROUP BY year_added
ORDER BY year_added;

-- Q3. Which country has produced the most titles overall?
SELECT country, COUNT(DISTINCT show_id) AS total_titles
FROM netflix_country
GROUP BY country
ORDER BY total_titles DESC
LIMIT 5;

-- Q4. What are the top 5 most common genres on Netflix?
SELECT genre, COUNT(*) AS num_titles
FROM netflix_genre
GROUP BY genre
ORDER BY num_titles DESC
LIMIT 5;

-- Q5. What is the average movie duration overall?
SELECT ROUND(AVG(CAST(REPLACE(duration, ' min', '') AS UNSIGNED)), 1) AS avg_duration_min
FROM netflix
WHERE type = 'Movie' AND duration LIKE '%min%';

-- Q6. What is the distribution of content ratings (e.g., TV-MA, PG-13)?
SELECT rating, COUNT(*) AS num_titles
FROM netflix
GROUP BY rating
ORDER BY num_titles DESC;

-- Q7. Which 10 directors have the most titles on Netflix?
SELECT director, COUNT(DISTINCT show_id) AS total_titles
FROM netflix_directors
WHERE director != 'Not Available'
GROUP BY director
ORDER BY total_titles DESC
LIMIT 10;

-- Q8. Which directors have created BOTH movies and TV shows?
SELECT nd.director,
       COUNT(DISTINCT CASE WHEN n.type='Movie' THEN n.show_id END) AS no_of_movies,
       COUNT(DISTINCT CASE WHEN n.type='TV Show' THEN n.show_id END) AS no_of_tvshows
FROM netflix n
JOIN netflix_directors nd ON n.show_id = nd.show_id
WHERE nd.director != 'Not Available'
GROUP BY nd.director
HAVING COUNT(DISTINCT n.type) > 1;

-- Q9. Which country has the highest number of Comedy movies specifically?
SELECT nc.country, COUNT(DISTINCT ng.show_id) AS comedy_movie_count
FROM netflix_genre ng
JOIN netflix_country nc ON ng.show_id = nc.show_id
JOIN netflix n ON ng.show_id = n.show_id
WHERE ng.genre = 'Comedies' AND n.type = 'Movie'
GROUP BY nc.country
ORDER BY comedy_movie_count DESC
LIMIT 1;

-- Q10. For each year, which director released the most movies? (window function)
WITH yearly_director_counts AS (
    SELECT nd.director, YEAR(n.date_added) AS year_added, COUNT(n.show_id) AS movie_count
    FROM netflix n
    JOIN netflix_directors nd ON n.show_id = nd.show_id
    WHERE n.type = 'Movie' AND nd.director != 'Not Available'
    GROUP BY nd.director, YEAR(n.date_added)
),
ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY year_added ORDER BY movie_count DESC, director) AS rnk
    FROM yearly_director_counts
)
SELECT year_added, director, movie_count
FROM ranked
WHERE rnk = 1
ORDER BY year_added;