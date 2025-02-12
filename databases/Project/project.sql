
/* Ερώτημα 1 */

SELECT YEAR(release_date) AS year , COUNT(*) AS movies_per_year
FROM movie
WHERE budget > 1000000
GROUP BY YEAR(release_date)
ORDER BY year DESC

/* Ερώτημα 2 */

SELECT genre.name AS genre,COUNT(*) AS movies_per_genre
FROM genre,hasGenre,movie
WHERE genre.id = hasGenre.genre_id AND hasGenre.movie_id = movie.id AND (movie.budget > 1000000 OR movie.runtime>120)
GROUP BY genre.name

/* Ερώτημα 3 */

SELECT genre.name as genre, YEAR(release_date) as year, COUNT(*) as  movies_per_gy
FROM movie
JOIN (genre 
    JOIN hasGenre ON genre.id=hasGenre.genre_id) 
    ON hasGenre.movie_id=movie.id
GROUP BY genre.name,YEAR(release_date)
HAVING YEAR(release_date) is not NULL

/* Ερώτημα 4 */

SELECT Year(release_date) AS year, SUM(revenue) AS revenues_per_year
FROM movie
INNER JOIN movie_cast ON (movie.id=movie_cast.movie_id AND movie_cast.name LIKE 'Morgan Freeman')
GROUP BY Year(release_date)

/* Ερώτημα 5 */

SELECT  Year(release_date) as year,  MAX(budget) AS max_budget
FROM movie
GROUP BY Year(release_date)
HAVING MAX(budget)>0
ORDER BY Year(release_date) DESC

/* Ερώτημα 6 */

SELECT collection.name AS trilogy_name
FROM collection
INNER JOIN (SELECT belongsTocollection.collection_id as collection_id,COUNT(belongsTocollection.movie_id) as movies
            FROM belongsTocollection
            GROUP BY collection_id) AS btg ON collection_id=collection.id AND btg.movies=3

/* Ερώτημα 7 */

SELECT AVG(rating) as avg_rating, COUNT(*) AS rating_count
FROM ratings
GROUP BY user_id

/* Ερώτημα 8 */

SELECT TOP(10) movie.title as movie_title, movie.budget as budget
FROM movie
ORDER BY budget DESC

/* Ερώτημα 9 */

SELECT  Year(release_date) as year, title as movies_with_max_revenues
FROM movie ,(SELECT  Year(release_date) as year,  MAX(budget) AS max_budget
        FROM movie
        GROUP BY Year(release_date) 
        HAVING MAX(budget)>0) Erotima_5
WHERE Erotima_5.year = YEAR(release_date) AND Erotima_5.max_budget=movie.budget
ORDER BY Year(release_date),title

/* Ερώτημα 10 */

CREATE VIEW Popular_Movie_Pairs AS
SELECT ratings.movie_id AS movie_id1, ratings_2.ID AS movie_id2,COUNT(*) as pair_popularity 
FROM ratings,(SELECT ratings.movie_id AS ID ,COUNT(*) as popularity 
              FROM ratings
              WHERE rating>4 
              Group by movie_id
              HAVING  COUNT(*)>10) as ratings_2
WHERE rating>4 AND ratings.movie_id != ratings_2.ID
Group by movie_id,ID
HAVING  COUNT(*)>10
