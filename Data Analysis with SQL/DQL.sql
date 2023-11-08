-- Which movies stayed in the theaters for the highest number of weeks?
SELECT m.movie_title,
       COUNT(bo.week) AS number_of_weeks
FROM movies m
JOIN box_office bo
ON m.movie_id = bo.movie_id
GROUP BY movie_title
HAVING number_of_weeks >= 25
ORDER BY number_of_weeks DESC;


-- Which movies stayed on top of the box office for the highest number of consecutive weeks?
SELECT m.movie_title,
       SUM(IF(bo.movie_rank = 1, 1, 0)) AS top_of_boxoffice
FROM movies m
JOIN box_office bo
ON m.movie_id = bo.movie_id
GROUP BY movie_title
HAVING top_of_boxoffice > 5
ORDER BY top_of_boxoffice DESC;


-- Which movie generated the highest revenue per week?
SELECT m.movie_title,
       bo.week,
       bo.year,
       FORMAT(MAX(bo.movie_weekly_revenue), 0) AS weekly_revenue
FROM movies m
JOIN box_office bo
ON m.movie_id = bo.movie_id
GROUP BY m.movie_title, bo.week, bo.year
ORDER BY MAX(bo.movie_weekly_revenue) DESC
LIMIT 5;


-- Which movie generated the highest revenues of all time?
SELECT movie_title,
       FORMAT(movie_total_revenue, 0) AS total_revenue
FROM movies
ORDER BY movie_total_revenue DESC
LIMIT 10;


-- For the highest earning movie, calculate the cumulative revenue over weeks.
SELECT m.movie_title,
       bo.year,
       bo.week,
       bo.movie_weekly_revenue,
       SUM(bo.movie_weekly_revenue) OVER (ORDER BY bo.week) AS cumulative_revenue
FROM movies m
JOIN box_office bo
ON m.movie_id = bo.movie_id
HAVING m.movie_title = (
    SELECT movie_title
    FROM movies
    ORDER BY movie_total_revenue DESC
    LIMIT 1
);


-- Which movies have the highest rating?
SELECT movie_title,
       movie_rating
FROM movies
WHERE movie_rating > 9
ORDER BY movie_rating DESC;


-- Is there a correlation between movie ratings and revenue?
SELECT CASE
        WHEN movie_rating < 3 THEN 'Terrible'
        WHEN movie_rating >= 3 AND movie_rating < 5 THEN 'Poor'
        WHEN movie_rating >= 5 AND movie_rating < 7 THEN 'Fair'
        WHEN movie_rating >= 7 AND movie_rating < 9 THEN 'Good'
        WHEN movie_rating >= 9 THEN 'Excellent'
       END AS rating_category,
       FORMAT(AVG(movie_total_revenue), 0) AS avg_revenue
FROM movies
GROUP BY rating_category
ORDER BY AVG(movie_total_revenue) DESC;


-- Which countries produced the highest number of movies?
SELECT m.movie_country,
       COUNT(DISTINCT bo.movie_id) AS number_of_movies
FROM movies m
JOIN box_office bo
ON m.movie_id = bo.movie_id
GROUP BY m.movie_country
ORDER BY number_of_movies DESC
LIMIT 10;


-- Which countries generated the highest amount of revenue?
SELECT movie_country,
       FORMAT(SUM(movie_total_revenue), 0) AS total_movie_revenue
FROM movies
GROUP BY movie_country
ORDER BY SUM(movie_total_revenue) DESC
LIMIT 10;


-- How did the average runtime change over the years?
SELECT YEAR(movie_release_date) AS release_year,
       ROUND(AVG(movie_length), 2) AS avg_runtime
FROM movies
GROUP BY release_year
HAVING release_year >= 2013
ORDER BY release_year;


-- What is the average runtime by genre?
SELECT movie_genre,
       ROUND(AVG(movie_length), 2) AS avg_runtime
FROM movies
GROUP BY movie_genre
ORDER BY avg_runtime DESC;


-- Is there a correlation between movie length and revenues?
SELECT CASE
        WHEN movie_length <= 45 THEN 'Short Films'
        WHEN movie_length > 45 AND movie_length <= 90 THEN 'Featurette Films'
        WHEN movie_length > 90 AND movie_length <= 135 THEN 'Standard Films'
        WHEN movie_length > 135 AND movie_length <= 170 THEN 'Extended Films'
        WHEN movie_length > 170 THEN 'Epic Films'
       END AS runtime_category,
       FORMAT(SUM(movie_total_revenue), 0) AS total_revenue
FROM movies
GROUP BY runtime_category
ORDER BY SUM(movie_total_revenue) DESC;


-- Which day of week witnessed the release of the highest number of movies?
SELECT DAYNAME(m.movie_release_date) AS release_day,
       COUNT(DISTINCT bo.movie_id) AS number_of_movies
FROM movies m
JOIN box_office bo
ON m.movie_id = bo.movie_id
GROUP BY release_day
ORDER BY number_of_movies DESC;


-- Which month witnessed the release of the highest number of Egyptian movies?
SELECT MONTHNAME(m.movie_release_date) AS release_month,
       COUNT(DISTINCT bo.movie_id) AS number_of_movies
FROM movies m
JOIN box_office bo
ON m.movie_id = bo.movie_id
WHERE movie_country = 'Egypt'
GROUP BY release_month
ORDER BY number_of_movies DESC;


-- Which month witnessed the release of the highest number of non-Egyptian movies?
SELECT MONTHNAME(m.movie_release_date) AS release_month,
       COUNT(DISTINCT bo.movie_id) AS number_of_movies
FROM movies m
JOIN box_office bo
ON m.movie_id = bo.movie_id
WHERE movie_country != 'Egypt'
GROUP BY release_month
ORDER BY number_of_movies DESC;


-- Is there a correlation between release month and revenues?
SELECT MONTHNAME(movie_release_date) AS release_month,
       FORMAT(SUM(movie_total_revenue), 0) AS total_revenue
FROM movies
GROUP BY release_month
ORDER BY SUM(movie_total_revenue) DESC;


-- Which year witnessed the highest number of movies?
SELECT YEAR(m.movie_release_date) AS release_year,
       COUNT(DISTINCT bo.movie_id) AS number_of_movies
FROM movies m
JOIN box_office bo
ON m.movie_id = bo.movie_id
GROUP BY release_year
HAVING release_year >= 2013
ORDER BY release_year;


-- Is there a correlation between release year and revenues?
SELECT Year(movie_release_date) AS release_year,
       FORMAT(SUM(movie_total_revenue), 0) AS total_revenue
FROM movies
GROUP BY release_year
HAVING release_year >= 2013
ORDER BY release_year;


-- How did the growth percentage of movies revenues change over the years?
SELECT year(movie_release_date) AS year,
       SUM(movie_total_revenue) AS total_revenue,
       LAG(SUM(movie_total_revenue)) OVER (ORDER BY year(movie_release_date)) AS prev_year_revenue,
       ((SUM(movie_total_revenue) - LAG(SUM(movie_total_revenue))
           OVER (ORDER BY year(movie_release_date))) / LAG(SUM(movie_total_revenue))
               OVER (ORDER BY year(movie_release_date))) * 100 AS revenue_growth_rate
FROM movies
GROUP BY year
HAVING year >= 2013;


-- For the highest earning year, determine the market penetration of each genre.
SELECT year(movie_release_date) as year,
       movie_genre,
       SUM(movie_total_revenue) AS genre_revenue,
       SUM(SUM(movie_total_revenue)) OVER (PARTITION BY year(movie_release_date)) AS total_year_revenue,
       (SUM(movie_total_revenue) / SUM(SUM(movie_total_revenue))
           OVER (PARTITION BY year(movie_release_date))) * 100 AS market_penetration
FROM movies
GROUP BY year, movie_genre
HAVING year = 2019
ORDER BY market_penetration DESC;


-- Which genre is the most popular?
SELECT m.movie_genre,
       COUNT(DISTINCT bo.movie_id) AS number_of_movies
FROM movies m
JOIN box_office bo
ON m.movie_id = bo.movie_id
GROUP BY m.movie_genre
ORDER BY number_of_movies DESC;


-- What is the total revenues per genre?
SELECT movie_genre,
       FORMAT(SUM(movie_total_revenue), 0) AS total_revenue
FROM movies
GROUP BY movie_genre
ORDER BY SUM(movie_total_revenue) DESC;


-- Which MPAA Age Category is the most popular?
SELECT m.movie_mpaa_rating,
       COUNT(DISTINCT bo.movie_id) AS number_of_movies
FROM movies m
JOIN box_office bo
ON m.movie_id = bo.movie_id
GROUP BY m.movie_mpaa_rating
ORDER BY number_of_movies DESC;


-- Does age restrictions affect movies profitability?
SELECT movie_mpaa_rating,
       FORMAT(SUM(movie_total_revenue), 0) AS total_revenue
FROM movies
GROUP BY movie_mpaa_rating
ORDER BY SUM(movie_total_revenue) DESC;


-- Who are the directors with the highest number of movies?
SELECT m.movie_director,
       COUNT(DISTINCT bo.movie_id) AS number_of_movies
FROM movies m
JOIN box_office bo
ON m.movie_id = bo.movie_id
GROUP BY m.movie_director
HAVING number_of_movies > 6
ORDER BY number_of_movies DESC;


-- Who are the most successful Egyptian directors by revenues?
SELECT movie_director,
       FORMAT(SUM(movie_total_revenue), 0) AS total_revenue
FROM movies
WHERE movie_country = 'Egypt'
GROUP BY movie_director
ORDER BY SUM(movie_total_revenue) DESC
LIMIT 10;


-- Who are the most successful non-Egyptian directors by revenues?
SELECT movie_director,
       FORMAT(SUM(movie_total_revenue), 0) AS total_revenue
FROM movies
WHERE movie_country != 'Egypt'
GROUP BY movie_director
ORDER BY SUM(movie_total_revenue) DESC
LIMIT 10;


-- Who are the writers with the highest number of movies?
SELECT w.writer_name,
       COUNT(mw.movie_id) AS number_of_movies
FROM writers w
JOIN movie_writers mw
ON w.writer_id = mw.writer_id
GROUP BY w.writer_name
HAVING number_of_movies > 5
ORDER BY number_of_movies DESC;


-- Who are the most successful Egyptian writers by revenues?
SELECT w.writer_name,
       FORMAT(SUM(m.movie_total_revenue), 0) AS total_revenue
FROM movies m
JOIN movie_writers mw
ON m.movie_id = mw.movie_id
JOIN writers w
ON mw.writer_id = w.writer_id
WHERE movie_country = 'Egypt'
GROUP BY w.writer_name
ORDER BY SUM(m.movie_total_revenue) DESC
LIMIT 10;


-- Who are the most successful non-Egyptian writers by revenues?
SELECT w.writer_name,
       FORMAT(SUM(m.movie_total_revenue), 0) AS total_revenue
FROM movies m
JOIN movie_writers mw
ON m.movie_id = mw.movie_id
JOIN writers w
ON mw.writer_id = w.writer_id
WHERE movie_country != 'Egypt'
GROUP BY w.writer_name
ORDER BY SUM(m.movie_total_revenue) DESC
LIMIT 10;


-- Who are the actors with the highest number of movies?
SELECT w.star_name,
       COUNT(ms.movie_id) AS number_of_movies
FROM stars w
JOIN movie_stars ms
ON w.star_id = ms.star_id
GROUP BY w.star_name
HAVING number_of_movies > 8
ORDER BY number_of_movies DESC;


-- Who are the most successful Egyptian actors by revenues?
SELECT w.star_name,
       FORMAT(SUM(m.movie_total_revenue), 0) AS total_revenue
FROM movies m
JOIN movie_stars mw
ON m.movie_id = mw.movie_id
JOIN stars w
ON mw.star_id = w.star_id
WHERE movie_country = 'Egypt'
GROUP BY w.star_name
ORDER BY SUM(m.movie_total_revenue) DESC
LIMIT 10;


-- Who are the most successful non-Egyptian actors by revenues?
SELECT w.star_name,
       FORMAT(SUM(m.movie_total_revenue), 0) AS total_revenue
FROM movies m
JOIN movie_stars mw
ON m.movie_id = mw.movie_id
JOIN stars w
ON mw.star_id = w.star_id
WHERE movie_country != 'Egypt'
GROUP BY w.star_name
ORDER BY SUM(m.movie_total_revenue) DESC
LIMIT 10;