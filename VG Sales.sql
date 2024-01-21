-- Data from kaggle.com, www.kaggle.com/datasets/gregorut/videogamesales

--Data cleaning and transformation
SELECT * FROM vgsales;

DELETE FROM vgsales WHERE EU_Sales = 'Misc';

DELETE FROM vgsales
WHERE ISNUMERIC(NA_Sales) = 0;

ALTER TABLE vgsales
ALTER COLUMN NA_Sales FLOAT;

ALTER TABLE vgsales
ALTER COLUMN EU_Sales FLOAT;

ALTER TABLE vgsales
ALTER COLUMN JP_Sales FLOAT;

ALTER TABLE vgsales
ALTER COLUMN Other_Sales FLOAT;

ALTER TABLE vgsales
ALTER COLUMN Global_Sales FLOAT;

SELECT *
FROM vgsales
WHERE TRY_CAST(EU_Sales AS FLOAT) IS NULL
   AND EU_Sales IS NOT NULL;

----SQL Queries 
SELECT * FROM vgsales;
--Which games have the highest global sales?
SELECT TOP 10 Name
FROM vgsales
ORDER BY Global_Sales DESC;

--What are the total sales for each gaming platform?
SELECT Platform, SUM(Global_Sales) AS Total_Sales
FROM vgsales
GROUP BY Platform
ORDER BY Total_Sales DESC;

--Which genre performs the best in North America?
SELECT TOP 1 Genre, SUM(NA_Sales) AS Total_Sales
FROM vgsales
GROUP BY Genre
ORDER BY Total_Sales DESC;

--Which publisher has the highest total sales globally?
SELECT Publisher, SUM(Global_Sales) AS Total_Sales
FROM vgsales
GROUP BY Publisher
ORDER BY Total_Sales DESC;

--How have our global sales been trending over the years?
SELECT Year, SUM(Global_Sales) AS Total_Sales
FROM vgsales
GROUP BY Year
ORDER BY Year ASC;

--What is the sales distribution for the top 10 games across North America, Europe, Japan, and other regions?
SELECT TOP 10 Name, NA_Sales, EU_Sales, JP_Sales, Other_Sales
FROM vgsales
ORDER BY Global_Sales DESC;

--What is the average global sales for all games?
SELECT AVG(Global_Sales) AS 'Average Global Sales'
FROM vgsales;

--Can you provide a list of games that performed well in both Europe and Japan?
SELECT TOP 10 Name, (EU_Sales + JP_Sales) AS EU_JP_Sales
FROM vgsales
ORDER BY EU_JP_Sales DESC;

----Harder SQL Queries

--What is the year-over-year growth rate in global sales for each game?

--Which gaming platform has the highest average global sales per game?

--Among the top publishers, which ones have a diverse portfolio of genres with high sales?

--Can you identify any trends in sales growth by analyzing the sales performance of games released in the last five years?

--Is there a correlation between the average critic scores of games and their global sales?

--Identify games that are outliers in terms of sales performance in each region (North America, Europe, Japan) compared to their respective genres.

--Can you analyze the dynamic market share of each gaming platform over the years, considering the changing landscape?

--Are there any indications of potential blockbuster franchises by analyzing the sales performance of games with sequels?