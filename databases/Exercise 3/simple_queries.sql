/*
1o)Βρες μου όλους τους ηθοποιούς οι οποίοι έχουν παίξει σε Οικογενειακές ταινίες καθως και ποιες ειναι αυτες
OUTPUT : 11757 rows
*/

SELECT DISTINCT movie_cast.name AS Actors ,family.title as Movie
FROM movie_cast
INNER JOIN (
    SELECT movie.id,movie.title
    FROM movie 
    JOIN (
        genre JOIN hasGenre 
        ON genre.id=hasGenre.genre_id AND genre.name='Family') 
    ON hasGenre.movie_id=movie.id
    ) family 
ON family.id=movie_cast.movie_id 
ORDER BY Movie



/*
2o)Βρες μου τους τίτλους απ’ όλες τις ταινίες που κυκλοφορήσαν μεταξύ το 1970 και του 1980 καθως και το genre τους με τουλάχιστον μια βαθμολογία από χρήστες ίση με το 5 
OUTPUT : 89 rows
*/

SELECT DISTINCT movie.title AS Title , genre.name as Genre
FROM ratings,movie
INNER JOIN (  
    genre JOIN hasGenre 
    ON genre.id=hasGenre.genre_id ) 
ON hasGenre.movie_id=movie.id
WHERE YEAR(movie.release_date) BETWEEN '1970' AND '1980' AND ratings.movie_id=movie.id AND ratings.rating=5
ORDER BY Genre



/*
3o)Βρες μου τους τίτλους των ταινιών με τα 10 μεγαλύτερα budget και τα budget τους
OUTPUT : 10 rows
*/

SELECT TOP(10) movie.title Title, movie.budget Budget
FROM movie
ORDER BY movie.budget DESC


/* 
4o)Βρες μου το μέσο κέρδος των ταινιών που διαρκούν λιγότερο από 120 λεπτά 
OUTPUT : 1 row
*/

SELECT AVG(CAST(movie.revenue AS bigint) ) as AVG_Revenue
FROM movie
WHERE movie.runtime<120



/*
5o)Βρες μου το όνομα της ταινίας με το μέγιστο revenue καθώς και τις εταιρείες που την έχουν παράξει
OUTPUT : 3 rows
*/

SELECT m.title as Title ,productioncompany.name Production_Company
FROM (
    SELECT movie.id,movie.title
    FROM movie
    WHERE revenue=(SELECT MAX(revenue) FROM movie)
)m
INNER JOIN(
    productioncompany JOIN hasProductioncompany
    ON productioncompany.id=hasProductioncompany.pc_id) 
ON hasProductioncompany.movie_id=m.id



/*
6o) Βρες την πρώτη ταινία που κυκλοφόρησε, πότε κυκλοφόρησε καθώς και όσα ratings πήρε από χρήστες
OUTPUT : 1 row
*/

SELECT m.title Title,m.release_date Release_Date,ratings.rating Rating
FROM(
SELECT movie.id,movie.title Title,movie.release_date Release_Date
FROM movie
WHERE movie.release_date=(SELECT MIN(release_date) FROM movie)
) m
INNER JOIN ratings ON ratings.movie_id=m.id



/*
7ο)Για κάθε συλλογή βρες μου το συνολικό κέρδος όλων των ταινιών που ανήκουν σε αυτήν
OUTPUT : 456 rows
*/

SELECT collection.name as Collection,final.revenue as Total_Revenue
FROM collection
INNER JOIN(
    SELECT movies.collections_id ,SUM(CAST( movies.revenue as bigint)) AS Revenue
    FROM (
        SELECT movie.revenue , collection.id as collections_id
        FROM movie,belongsTocollection,collection
        WHERE movie.id = belongsTocollection.movie_id AND belongsTocollection.collection_id=collection.id
        ) movies 
    GROUP BY movies.collections_id) final ON final.collections_id=collection.id and final.Revenue >0
ORDER BY Revenue DESC 


/*
8o)Βρες μου όλες τις ταινίες τις οποίες έχει συμμετάσχει στην παραγωγή κάποιος με το όνομα George
OUTPUT : 1341 rows
*/

SELECT movie.title as Movie, movie_crew.name as Crew_Name
FROM movie
INNER JOIN movie_crew ON movie_crew.movie_id=movie.id AND movie_crew.name LIKE 'George%'


/* 
9o)Επίστρεψε τα ονόματα των ταινιών που δεν ανήκουν σε κάποιο collection
OUTPUT : 8573
*/

SELECT movie.title as Movie
FROM movie
LEFT JOIN belongsTocollection on movie.id=belongsTocollection.movie_id
WHERE belongsTocollection.movie_id is NULL


/*
10)Βρες σε πόσες  ταινίες έχει παίξει ο Morgan Freeman και ποιον χαρακτηρα υποδυόταν 
OUTPUT : 34 
*/

SELECT movie.title as Movie , movie_cast.character as Character
FROM movie
INNER JOIN movie_cast ON  movie.id=movie_cast.movie_id AND movie_cast.name='Morgan Freeman'


/*
11o)Επέστρεψε μου όλες τις ταινίες που βγήκαν μετά το 2000 καθως και τα genre τους (αμα εχουν)
OUTPUT : 2496
*/

SELECT movie.title as Movie,genre.name as Genre
FROM movie
FULL OUTER JOIN (
        genre JOIN hasGenre 
        ON genre.id=hasGenre.genre_id) 
    ON hasGenre.movie_id=movie.id
WHERE YEAR(movie.release_date) > 2000 


/*
12o)Βρες όλες τις ταινίες που σχετίζονται με φόνο καθως και τις εταιρειες που τις εχουν παραξει
OUTPUT : 933 rows
*/

SELECT movie.title as Movie,productioncompany.name as Production_Company 
FROM haskeyword,Keyword ,movie
INNER JOIN (
        productioncompany JOIN hasProductioncompany 
        ON productioncompany.id=hasProductioncompany.pc_id) 
    ON hasProductioncompany.movie_id=movie.id
WHERE movie.id=haskeyword.movie_id AND haskeyword.keyword_id=Keyword.id AND  Keyword.name='murder'