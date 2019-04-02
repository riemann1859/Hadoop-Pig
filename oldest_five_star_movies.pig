--find_the_oldest_five_star_movies

ratings = LOAD '/user/maria_dev/ml-10m/ratings.dat' USING TextLoader() AS (line:chararray);


ratings1 = FOREACH ratings GENERATE    (int)STRSPLIT(TRIM(line),'::',4).$0 AS userID, 
									   (int)STRSPLIT(TRIM(line),'::',4).$1 AS movieID, 
                                       (float)STRSPLIT(TRIM(line),'::',4).$2 AS rating,
                                       (int)STRSPLIT(TRIM(line),'::',4).$3 AS ratingTime;

movies_data = LOAD '/user/maria_dev/ml-10m/movies.dat' USING TextLoader() AS (name:chararray);

    
movies_data1 = FOREACH movies_data GENERATE (int)STRSPLIT(TRIM(name),'::',3).$0 AS movieID, 
											STRSPLIT(TRIM(name),'::',3).$1 AS movieTitle, 
                                            STRSPLIT(TRIM(name),'::',3).$2 AS genres;
-- we now extract the release year of the movie from movieTitle column

movies_data2 = FOREACH movies_data1 GENERATE  movieID, 
								(chararray)SUBSTRING(movieTitle,0,LAST_INDEX_OF(movieTitle,'(')) AS movie_title, 
								(int)SUBSTRING(movieTitle,LAST_INDEX_OF(movieTitle,'(')+1,LAST_INDEX_OF(movieTitle,')')) AS release_year;



ratingsByMovie = Group ratings1 BY movieID;
-- grouping the relation ratings1 according to movieID column

avgRatings = FOREACH ratingsByMovie GENERATE group AS movieID, AVG(ratings1.rating) AS avgRating;

--How to select some specific rows from a relation: FILTER

fiveStarMovies = FILTER avgRatings BY avgRating > 4.0;
 
--How to combine two relational databases according to some common columns: JOIN

fiveStarsWithData = JOIN fiveStarMovies BY movieID, movies_data2 BY movieID;
fiveStarsWithData_ = FOREACH fiveStarsWithData GENERATE movie_title, release_year, avgRating;
fiveStarsWithData_ordered = ORDER fiveStarsWithData_ BY release_year;


DUMP fiveStarsWithData_ordered;
