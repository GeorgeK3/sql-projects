SELECT person_id 
FROM Person
GROUP BY person_id
HAVING COUNT(person_id) > 1

UPDATE movie_crew
SET name = 'Cheung Ka-Fai'
WHERE person_id = 63574

UPDATE movie_cast 
SET gender = 2
WHERE person_id = 47395

UPDATE movie_cast
SET gender = 0 
WHERE person_id = 1785844