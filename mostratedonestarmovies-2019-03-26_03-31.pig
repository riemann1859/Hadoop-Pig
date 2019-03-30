
--in ratings and movies datasets, columns are seperated by ::
--using pigstorage leads to some difficulties when a separator consists of at least two characters
--by textloader  every line is read as a whole string

ratings = LOAD '/user/maria_dev/ml-10m/ratings.dat' USING TextLoader() AS (line:chararray);


ratings1 = FOREACH ratings GENERATE    (int)STRSPLIT(TRIM(line),'::',4).$0 AS userID, 
									   (int)STRSPLIT(TRIM(line),'::',4).$1 AS movieID, 
                                       (float)STRSPLIT(TRIM(line),'::',4).$2 AS rating,
                                       (int)STRSPLIT(TRIM(line),'::',4).$3 AS ratingTime;

movies_data = LOAD '/user/maria_dev/ml-10m/movies.dat' USING TextLoader() AS (name:chararray);

    
movies_data1 = FOREACH movies_data GENERATE (int)STRSPLIT(TRIM(name),'::',3).$0 AS movieID, 
											STRSPLIT(TRIM(name),'::',3).$1 AS movieTitle, 
                                            STRSPLIT(TRIM(name),'::',3).$2 AS genres;
ratingsByMovie = Group ratings1 BY movieID;
-- grouping the relation ratings according to movieID column

avgRatings = FOREACH ratingsByMovie GENERATE group AS movieID, AVG(ratings1.rating) AS avgRating,
	COUNT(ratings1.userID) as NumberOfPerson;
--avgRating is related to quality of film
--NumberOfPerson is related to popularity of film

--How to select some specific rows from a relation: FILTER

badMovies = FILTER avgRatings BY avgRating < 2.0;

namedBadMovies = JOIN badMovies BY movieID, movies_data1 BY movieID;

--select only three columns from namedBadMovies
namedBadMovies_ = FOREACH namedBadMovies GENERATE avgRating, NumberOfPerson, movieTitle;

sortedBadMovies = ORDER namedBadMovies_ BY NumberOfPerson DESC;

DUMP sortedBadMovies;

