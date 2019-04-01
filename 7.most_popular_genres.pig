

ratings = LOAD '/user/maria_dev/ml-10m/ratings.dat' USING TextLoader() AS (line:chararray);
  

ratings1 = FOREACH ratings GENERATE    (int)STRSPLIT(TRIM(line),'::',4).$0 AS userID, 
				      (int)STRSPLIT(TRIM(line),'::',4).$1 AS movieID, 
                                       (float)STRSPLIT(TRIM(line),'::',4).$2 AS rating,
                                       (int)STRSPLIT(TRIM(line),'::',4).$3 AS ratingTime;

movies_data = LOAD '/user/maria_dev/ml-10m/movies.dat' USING TextLoader() AS (name:chararray);

    
movies_data1 = FOREACH movies_data GENERATE (int)STRSPLIT(TRIM(name),'::',3).$0 AS movieID, 
	                                      STRSPLIT(TRIM(name),'::',3).$1 AS movieTitle, 
                                            STRSPLIT(TRIM(name),'::',3).$2 AS genres;

movies_data2 = FOREACH movies_data1 GENERATE movieID, movieTitle, 
                                            FLATTEN(TOKENIZE(TRIM(genres),'|')) AS genre;
                                            
combined_data = JOIN movies_data2 BY movieID, ratings1 BY movieID;
                                

groupedByGenre = Group combined_data BY genre;

genre_popularity = FOREACH groupedByGenre GENERATE group AS genre, COUNT(combined_data) AS count_;


genre_popularity_ordered = ORDER genre_popularity BY count_ DESC;

DUMP genre_popularity_ordered;

