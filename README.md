# 🛢️ SQL Portfolio
The following are projects that showcase my expertise in SQL.

## Video Game Sales Analysis with SQL 🎮📈 [(Script)](https://github.com/luisintalan/SQL-portfolio/blob/main/VG%20Sales.sql)

The dataset consists of a list of video games with greater than 100,000 copies sold. The csv file from Kaggle was loaded onto Microsoft SQL Server using built-in import function.

The various features include:

| **Feature** | **Description** |
|---|---|
| Rank  | Ranking of overall sales |
| Name | Name of game  |
| Platform | Platform released in (i.e. PC, PS4, etc.) |
| Year | Year released in |
| Genre | Game genre |
| Publisher | Game publisher |
| NA_Sales | Sales in North America (in millions) |
| EU_Sales | Sales in Europe (in millions) |
| JP_Sales | Sales in Japan (in millions) |
| Other_Sales | Sales in the rest of the world (in millions) |
| Global_Sales | Total worldwide sales |

This SQL script analyzes the "Video Game Sales" dataset sourced from [Kaggle.](www.kaggle.com/datasets/gregorut/videogamesales)

Includes:

## **1. Data Cleaning and Transformation**
* Using **DELETE** clause to remove of irrelevant entries with insufficient data in Sales Columns
* Using **ALTER** clause to convert Sales columns to the appropriate data type.

## **2. SQL Queries for Analysis**
* Using **SELECT** statements to uncover valuable insights within the "Video Game Sales" dataset:

*Highlighted Queries:*
* Analyzed outliers in sales performance across regions and genres.

  * Utilized **common table expressions (CTEs)** to calculate genre-wise statistics, including **average sales** and **standard deviations**.
  * Employed **subqueries** to filter out games that deviated significantly from the genre norms in North America, Europe, and Japan.
 
* Explored market share dynamics of the Wii U platform over specific years.

  * Used a **CTE (Common Table Expression)** to aggregate sales data for the Wii U platform, grouping by year.
  * Applied **window functions** to calculate the total sales per year for contextualizing market share percentages.

*Note: Only main parts are highlighted; view [script](https://github.com/luisintalan/SQL-portfolio/blob/main/VG%20Sales.sql) script for detailed SQL queries and analysis.*
