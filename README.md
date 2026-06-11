# Netflix Movies and TV Shows Data Analysis Using SQL

![](https://github.com)

## Overview
This project involves a comprehensive analysis of Netflix's movies and TV shows data using PostgreSQL. The goal is to extract valuable insights regarding content trends, duration distributions, ratings, and release patterns to answer key business questions.

## Dataset
The data for this project is sourced from the Kaggle dataset:
* **Dataset Link:** [Netflix Movies and TV Shows Dataset](https://kaggle.com)

## Schema Setup
```sql
DROP TABLE IF EXISTS netflix;

CREATE TABLE netflix (
    show_id      TEXT PRIMARY KEY,
    type         TEXT,
    title        TEXT,
    director     TEXT,
    cast         TEXT,
    country      TEXT,
    date_added   TEXT,
    release_year INT,
    rating       TEXT,
    duration     TEXT,
    listed_in    TEXT,
    description  TEXT
);
```

## Key Business Problems Addressed
1. **Content Distribution:** Count the total number of Movies vs TV Shows.
2. **Most Common Ratings:** Find the most frequent rating for both movies and TV shows.
3. **Content Additions:** Filter and analyze content added to the platform within the last 5 years.
4. **Duration Metrics:** Identify the longest movies by isolating and sorting numeric durations.
5. **Categorization:** Analyze and group content based on specific descriptions and genres.

## Sample Complex Query Showcase
Here is an example of handling text-to-date conversions and clean data trimming used in this project:
```sql
SELECT *, TO_DATE(TRIM(DATE_ADDED), 'DD-Mon-YY') as clean_date
FROM netflix
WHERE TO_DATE(TRIM(DATE_ADDED), 'DD-Mon-YY') >= CURRENT_DATE - INTERVAL '5 years';
```

## Tech Stack Used
* **Database Management System:** PostgreSQL
* **Tool:** pgAdmin 4
* **Version Control:** Git & GitHub
