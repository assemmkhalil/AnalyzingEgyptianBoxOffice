-- Creating movies table

CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    movie_title VARCHAR(100),
    movie_rating DECIMAL(3,1),
    movie_country VARCHAR(50),
    movie_length INT,
    movie_release_date DATE,
    movie_genre VARCHAR(50),
    movie_mpaa_rating VARCHAR(10),
    movie_director VARCHAR(50),
    movie_total_revenue INT
);

-- Creating box_office table

CREATE TABLE box_office (
    year INT,
    week INT,
    movie_rank INT,
    movie_id INT,
    movie_weekly_revenue INT,
    PRIMARY KEY (year, week, movie_rank),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);

-- Creating writers table

CREATE TABLE writers (
    writer_id INT PRIMARY KEY,
    writer_name VARCHAR(50)
);

-- Creating movie_writers table

CREATE TABLE movie_writers (
    movie_id INT,
    writer_id INT,
    PRIMARY KEY (movie_id, writer_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (writer_id) REFERENCES writers(writer_id)
);

-- Creating stars table

CREATE TABLE stars (
    star_id INT PRIMARY KEY,
    star_name VARCHAR(50)
);

-- Creating movie_stars table

CREATE TABLE movie_stars (
    movie_id INT,
    star_id INT,
    PRIMARY KEY (movie_id, star_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (star_id) REFERENCES stars(star_id)
);

-- Loading data into writers table

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/writers_table.csv'
INTO TABLE writers
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Loading data into stars table

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/stars_table.csv'
INTO TABLE stars
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Loading data into movies table

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/movies_table.csv'
INTO TABLE movies
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Loading data into movie_writers table

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/movie_writers_table.csv'
INTO TABLE movie_writers
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Loading data into movie_stars table

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/movie_stars_table.csv'
INTO TABLE movie_stars
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Loading data into box_office table

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/box_office_table.csv'
INTO TABLE box_office
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
