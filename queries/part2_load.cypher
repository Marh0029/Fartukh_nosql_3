CREATE CONSTRAINT user_id IF NOT EXISTS
FOR (u:User)
REQUIRE u.userId IS UNIQUE;

CREATE CONSTRAINT movie_id IF NOT EXISTS
FOR (m:Movie)
REQUIRE m.movieId IS UNIQUE;

CREATE CONSTRAINT genre_name IF NOT EXISTS
FOR (g:Genre)
REQUIRE g.name IS UNIQUE;

// Users
LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/Marh0029/Fartukh_nosql_3/main/import/users.csv'
AS row

MERGE (u:User {userId: toInteger(row.userId)})
SET
u.gender = row.gender,
u.age = toInteger(row.age),
u.occupation = toInteger(row.occupation);

// Movies + Genres
LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/Marh0029/Fartukh_nosql_3/main/import/movies.csv'
AS row

MERGE (m:Movie {movieId: toInteger(row.movieId)})
SET m.title = row.title

WITH m,row
UNWIND split(row.genres,'|') AS genreName

MERGE (g:Genre {name: genreName})
MERGE (m)-[:HAS_GENRE]->(g);


// ratings (user + movie)
CALL apoc.periodic.iterate(
'
LOAD CSV WITH HEADERS
FROM "https://raw.githubusercontent.com/Marh0029/Fartukh_nosql_3/main/import/ratings.csv"
AS row
RETURN row
',
'
MATCH (u:User {userId: toInteger(row.userId)})
MATCH (m:Movie {movieId: toInteger(row.movieId)})
MERGE (u)-[r:RATED]->(m)
SET r.rating = toFloat(row.rating),
    r.timestamp = toInteger(row.timestamp)
',
{batchSize:10000, parallel:false}
)


MATCH ()-[r:RATED]->()
RETURN count(r); 