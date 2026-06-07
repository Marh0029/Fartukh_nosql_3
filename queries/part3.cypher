// Фільми жанру Thriller із середнім рейтингом > 4
MATCH (m:Movie)-[:HAS_GENRE]->(:Genre {name:'Thriller'})
MATCH ()-[r:RATED]->(m)
WITH m, avg(r.rating) AS avgRating
WHERE avgRating > 4
RETURN m.title, round(avgRating*100)/100 AS avgRating
ORDER BY avgRating DESC;

// Користувачі, які поставили 5 більше ніж 50 фільмам
MATCH (u:User)-[r:RATED]->()
WHERE r.rating = 5
WITH u, count(r) AS fiveStars
WHERE fiveStars > 50
RETURN u.userId, fiveStars
ORDER BY fiveStars DESC;

// Фільми, які високо оцінили User 1 та User 2
MATCH (u1:User {userId:1})-[r1:RATED]->(m:Movie)
MATCH (u2:User {userId:2})-[r2:RATED]->(m)
WHERE r1.rating >= 4
  AND r2.rating >= 4
RETURN m.title,
       r1.rating AS user1Rating,
       r2.rating AS user2Rating;


// Жанри з високими рейтингами
MATCH (m:Movie)-[:HAS_GENRE]->(g:Genre)
MATCH ()-[r:RATED]->(m)

WITH g,
     avg(r.rating) AS avgRating,
     count(r) AS ratingsCount

RETURN g.name,
       round(avgRating*100)/100 AS avgRating,
       ratingsCount
ORDER BY avgRating DESC;