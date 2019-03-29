

ratings = LOAD '/user/maria_dev/ml-100k/u.data'  AS (userID:int, movieID:int, rating:int, ratingTime:int);
-- ratings is the new relational database with four columns
metadata = LOAD '/user/maria_dev/ml-100k/u.item' USING PigStorage('|') 
			AS (movieID:int, movieTitle:chararray);
-- use pigsore if you need a different delimiter(different than \t)       


ratingsByMovie = Group ratings BY movieID;
-- grouping the relation ratings according to movieID column

avgRatings = FOREACH ratingsByMovie GENERATE group AS movieID, AVG(ratings.rating) AS avgRating,
	COUNT(ratings.userID) as NumberOfPerson;

--How to select some specific rows from a relation: FILTER

badMovies = FILTER avgRatings BY avgRating < 2.0;

namedBadMovies = JOIN badMovies BY movieID, metadata BY movieID;

sortedBadMovies = ORDER namedBadMovies BY NumberOfPerson DESC;

DUMP sortedBadMovies;