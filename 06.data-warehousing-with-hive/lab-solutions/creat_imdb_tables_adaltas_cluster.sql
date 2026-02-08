-- create db: <COURSE_GROUP_NAME>
CREATE DATABASE IF NOT EXISTS <COURSE_GROUP_NAME>;

-- imdb_name_basics
CREATE EXTERNAL TABLE <COURSE_GROUP_NAME>.imdb_name_basics (
    nconst STRING COMMENT 'a unique id of the name/person',
    primaryname STRING COMMENT 'name by which the person is most often credited',
    birthyear INT COMMENT 'in YYYY format',
    deathyear INT COMMENT 'in YYYY format if applicable, else \\N',
    primaryprofession ARRAY<STRING> COMMENT 'the top-3 professions of the person',
    knownfortitles ARRAY<STRING> COMMENT 'titles the person is known for'
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE
LOCATION 'hdfs://au/education/<COURSE_GROUP_NAME>/resources/lab4/imdb/name_basics/'
TBLPROPERTIES ('skip.header.line.count'='1');

-- imdb_title_basics
CREATE EXTERNAL TABLE <COURSE_GROUP_NAME>.imdb_title_basics (
    tconst STRING COMMENT 'a unique id for each video title',
    titletype STRING COMMENT 'the type/format of the title (e.g. movie, short, TV series, etc)',
    primarytitle STRING COMMENT 'the more popular title / the promotional title',
    originaltitle STRING COMMENT 'original title, in the original language',
    isadult STRING COMMENT '0: non-adult title; 1: adult title',
    startyear INT COMMENT 'release year of the title; for TV series, the start year',
    endyear INT COMMENT 'TV series end year; \\N for others',
    runtimeminutes INT COMMENT 'runtime in minutes',
    genres ARRAY<STRING> COMMENT 'genres associated with the title'
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE
LOCATION '/education/<COURSE_GROUP_NAME>/resources/lab4/imdb/title_basics'
TBLPROPERTIES ('skip.header.line.count'='1');

-- imdb_title_crew
CREATE EXTERNAL TABLE <COURSE_GROUP_NAME>.imdb_title_crew (
    tconst STRING COMMENT 'a unique id of the title',
    director ARRAY<STRING> COMMENT 'director(s) of the given title (nconsts)',
    writers ARRAY<STRING> COMMENT 'writer(s) of the given title'
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE
LOCATION '/education/<COURSE_GROUP_NAME>/resources/lab4/imdb/title_crew'
TBLPROPERTIES ('skip.header.line.count'='1');

-- imdb_title_ratings
CREATE EXTERNAL TABLE <COURSE_GROUP_NAME>.imdb_title_ratings (
    tconst STRING COMMENT 'a unique id of the title',
    averagerating DOUBLE COMMENT 'weighted average of all the individual user ratings',
    numvotes SMALLINT COMMENT 'number of votes the title has received'
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE
LOCATION '/education/<COURSE_GROUP_NAME>/resources/lab4/imdb/title_ratings/'
TBLPROPERTIES ('skip.header.line.count'='1');
    