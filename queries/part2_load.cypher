CREATE CONSTRAINT user_id IF NOT EXISTS
FOR (u)
REQUIRE u.userId IS UNIQUE;

CREATE CONSTRAINT movie_id IF NOT EXISTS
FOR (m)
REQUIRE m.movieId IS UNIQUE;

CREATE CONSTRAINT genre_name IF NOT EXISTS
FOR (g)
REQUIRE g.name IS UNIQUE;

// Users
LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/Marh0029/Fartukh_nosql_3/main/import/users.csv'
AS row

MERGE (u {userId: toInteger(row.userId)})
SET
u.gender = row.gender,
u.age = toInteger(row.age),
u.occupation = toInteger(row.occupation);

// Movies + Genres
LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/Marh0029/Fartukh_nosql_3/main/import/movies.csv'
AS row

MERGE (m {movieId: toInteger(row.movieId)})
SET m.title = row.title

WITH m,row
UNWIND split(row.genres,'|') AS genreName

MERGE (g {name: genreName})
MERGE (m)-[]->(g);