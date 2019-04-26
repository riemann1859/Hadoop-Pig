REGISTER 'hdfs://sandbox-hdp.hortonworks.com:8020/user/maria_dev/bagtobag.py' using jython as myudfs;



movies_data = LOAD '/user/maria_dev/ml-10m/movies.dat' USING TextLoader() AS (line:chararray);

    
movies_data1 = FOREACH movies_data GENERATE (chararray)STRSPLIT(TRIM(line),'::',3).$1 AS movieTitle, 
                                            (chararray)STRSPLIT(TRIM(line),'::',3).$2 AS genres;
                                            
movies_data2 = FOREACH movies_data1 GENERATE movieTitle,
											FLATTEN(TOKENIZE(TRIM(genres),'|')) AS genre;
                                            
--TOKENIZE ans STRSPLIT are very similar functions, but in the just above case STRPLIT does not work, I couldnt catch



movies_data3 = FOREACH movies_data2 GENERATE  genre,
								(int)SUBSTRING(movieTitle,LAST_INDEX_OF(movieTitle,'(')+1,LAST_INDEX_OF(movieTitle,')')) AS release_year;

movies_data4 = FOREACH movies_data3 GENERATE  genre,  release_year-( release_year % 10) AS decade;

groupedBYGenreandDecade = GROUP movies_data4 BY (genre, decade);

number_of_movies_with_a_given_genre_over_a_given_decade = FOREACH groupedBYGenreandDecade GENERATE group.genre AS genre,
                 group.decade AS decade, COUNT(movies_data4) AS COUNT_;


x = GROUP  number_of_movies_with_a_given_genre_over_a_given_decade BY decade;

y = FOREACH x GENERATE  group AS decade, myudfs.percentage(number_of_movies_with_a_given_genre_over_a_given_decade) as t;

z = FOREACH y GENERATE FLATTEN(t);
DUMP z;


