


movies_data = LOAD '/user/maria_dev/ml-10m/movies.dat' USING TextLoader() AS (line:chararray);

    
movies_data1 = FOREACH movies_data GENERATE (int)STRSPLIT(TRIM(line),'::',3).$0 AS movieID, 
											(chararray)STRSPLIT(TRIM(line),'::',3).$1 AS movieTitle, 
                                            (chararray)STRSPLIT(TRIM(line),'::',3).$2 AS genres;
                                            
movies_data2 = FOREACH movies_data1 GENERATE movieID, movieTitle,
											FLATTEN(TOKENIZE(TRIM(genres),'|')) AS genre;
                                            
--TOKENIZE ans STRSPLIT are very similar functions, but in the just above case STRPLIT does not work, I couldnt catch

groupedMovies = GROUP movies_data2 BY genre;

genre_counts = FOREACH groupedMovies GENERATE group AS genre, COUNT(movies_data2) as count_;

genre_counts_ordered = ORDER genre_counts BY count_ DESC;

DUMP genre_counts_ordered;