# Netflix-Data-Cleaning-Analysis
An end-to-end data cleaning and analysis project on Netflix's global content catalog, using Python and SQL.

# 🎬 Netflix Data Cleaning & Analysis — Data Analyst Portfolio Project

An end-to-end data cleaning and analysis project on Netflix's global content
catalog, using Python and SQL.

## 📌 Project Overview

Netflix's raw catalog data has multi-value fields crammed into single text
columns (a title can list several genres, countries, and directors at once),
missing values, and duplicate entries. This project cleans that data into a
proper relational structure and answers real content-strategy questions:

✅ **Data Cleaning (Python)** — Removed duplicates, filled missing values, and split comma-separated columns (genre, country, director) into normalized tables
✅ **Data Analysis (SQL)** — Answered 10 business questions using joins, CTEs, and window functions across 4 related tables

## 📊 Dataset

Kaggle **"Netflix Movies and TV Shows"** — ~8,800 titles with fields including
type, title, director, cast, country, date added, release year, rating,
duration, listed genres, and description.
Link: https://www.kaggle.com/datasets/shivamb/netflix-shows

Publicly available dataset used for portfolio/educational purposes.

## 🧹 Data Cleaning Highlights

- Removed duplicate titles (same title + type appearing more than once)
- Filled missing `director`, `country`, `cast`, and `duration` values with
  `"Not Available"` rather than dropping rows and losing other valid data
- **Split multi-value columns into separate normalized tables** — the raw
  `listed_in`, `country`, and `director` columns each contained
  comma-separated lists (e.g. `"Comedies, Dramas"`); these were exploded
  into one row per value in dedicated `netflix_genre`, `netflix_country`,
  and `netflix_directors` tables, so they can be joined and queried properly

## 🗄️ Database Structure

| Table | Description |
|---|---|
| `netflix` | Core title data — show_id, type, title, date_added, rating, duration, description |
| `netflix_genre` | One row per show_id/genre combination |
| `netflix_country` | One row per show_id/country combination |
| `netflix_directors` | One row per show_id/director combination |

## 📈 Key Findings

*(Fill in with your real results once you've run the queries)*
- Netflix's catalog is **[X]% Movies vs. [X]% TV Shows**
- Content additions peaked in **[year]**
- **[Country]** produces the most titles overall, and the most Comedy movies specifically
- The most common genre is **[genre]**, appearing in **[X]** titles
- **[Director]** has directed both movies and TV shows on the platform — **[X]** movies and **[X]** TV shows
- Average movie duration is **[X] minutes**

## 🛠️ How to Use This Project

1. Download `netflix_titles.csv` from the Kaggle link above
2. Open `Netflix_Data_Cleaning_Analysis.ipynb` to clean the data and split it into the 4 tables
3. Load the resulting CSVs into a MySQL database named `netflix_db`
4. Run `netflix_sql_queries.sql` in MySQL Workbench

## 🗂️ Files

| File | Description |
|---|---|
| `Netflix_Data_Cleaning_Analysis.ipynb` | Python cleaning, deduplication, and column-splitting |
| `netflix_main_cleaned.csv`, `netflix_genre.csv`, `netflix_country.csv`, `netflix_directors.csv` | Cleaned, normalized tables |
| `netflix_sql_queries.sql` | 10 SQL business questions, simple to complex |
| `Business_Problem_Document.pdf` | Business problem, objectives, and scope |

## 🧰 Tools Used

Python (Pandas, NumPy) · MySQL  · Jupyter Notebook

## 👨‍💻 About

Built by **G Abishek** as a data analytics portfolio project.
[LinkedIn](https://www.linkedin.com/in/gabishek) · [GitHub](https://github.com/abishek2701)
