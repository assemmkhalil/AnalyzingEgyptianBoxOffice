# Analyzing the Egyptian Box Office
![0- Dashboard](https://github.com/assemmkhalil/AnalyzingEgyptianBoxOffice/assets/126206911/c08a6c13-5582-4242-9ff2-e64eea43da43)


## Project Overview:
The Egyptian movie industry is a dynamic and competitive market, witnessing a constant influx of movies from different countries and across different genres. However, without a detailed understanding of factors such as timing, popular genres, successful directors, writers, and stars, industry professionals are limited in their ability to make informed decisions. To address this challenge, this project aims to conduct an in-depth analysis of the Egyptian box office over the past decade. By leveraging Python, SQL, and Tableau, the project seeks to uncover valuable patterns and trends, providing stakeholders with actionable insights for strategic planning, marketing, and investment within the Egyptian movie industry.

## About the Data:
The data for this project was scraped from [elcinema.com](elcinema.com). The dataset includes information on various aspects of movies, such as year, week, rank, title, rating, country, runtime, release date, genre, MPAA rating, director, writers, stars, weekly revenue, and total revenue. The data was structured into six different tables to ensure data normalization, with the relationships between tables being well-defined, facilitating efficient data analysis:
1. movies_table: Contains general information about movies.
2. writers_table: Contains information about the writers of movies.
3. movie_writers_table: Serves as a bridge table connecting movies to their writers.
4. stars_table: Contains details about the stars of movies.
5. movie_stars_table: Serves as a bridge table connecting movies to their stars.
6. box_office_table: Contains data on weekly box office performance.
![ERD](https://github.com/assemmkhalil/AnalyzingEgyptianBoxOffice/assets/126206911/4384d667-27e6-4e54-abbd-2d5eb3a4d1d8)


## Methodology:
1. Data Collection: Utilized Python's Requests and Beautiful Soup libraries to scrape movie data from the online database, and organized the data into six normalized tables to avoid redundancy.
2. Data Cleaning: Pandas was used to clean the data, including error correction, handling null values, and removing duplicates.
3. Database Creation: SQL DDL and DML were employed to create and populate the six tables in a relational database, with established relationships between them.
4. Data Analysis using SQL: A variety of SQL queries were used to extract valuable insights from the data, such as trends in box office performance, popular genres, and successful directors and actors.
5. Data Analysis using Tableau: The cleaned data was loaded into Tableau for data visualization. New calculated fields were created and various visualizations were used to gain a deeper understanding of the data. In the end, a dynamic Tableau dashboard was created to summarize the project's findings and make it more accessible for stakeholders.
6. Presentation: Created a comprehensive presentation to better communicate the analysis findings and insights to stakeholders.

## Findings:
For the detailed findings and insights, please refer to the presentation file.
