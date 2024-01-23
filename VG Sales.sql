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

SELECT * FROM vgsales;
--Which gaming platform has the highest average global sales per game?
SELECT TOP 10 Platform, AVG(Global_Sales) AS Average_Sales
FROM vgsales
GROUP BY Platform
HAVING COUNT(Name) > (
	SELECT AVG(GameCount) 
	FROM (
		SELECT Platform, COUNT(Name) AS GameCount 
		FROM vgsales 
		GROUP BY Platform
) 
	AS PlatformGameCount
)
ORDER BY Average_Sales;

--Among the top publishers, which ones have a diverse portfolio of genres with high sales? 
--Hint: Combine data from multiple queries using subqueries or JOIN operations.
SELECT TOP 10 Publisher, SUM(Global_Sales) AS Total_Sales, COUNT(DISTINCT Genre) AS No_of_Genre
FROM vgsales
GROUP BY Publisher
ORDER BY Total_Sales DESC;

SELECT Publisher, COUNT(DISTINCT Genre) AS No_of_Genre
FROM vgsales
WHERE Publisher = 'Nintendo'
GROUP BY Publisher
ORDER BY No_of_Genre DESC;

--Identify games that are outliers in terms of sales performance in each region (North America, Europe, Japan) compared to their respective genres. 
WITH GenreStatistics AS (
    SELECT
        Genre,
        AVG(NA_Sales) AS Avg_NA_Sales,
        AVG(EU_Sales) AS Avg_EU_Sales,
        AVG(JP_Sales) AS Avg_JP_Sales,
        STDEV(NA_Sales) AS StdDev_NA_Sales,
        STDEV(EU_Sales) AS StdDev_EU_Sales,
        STDEV(JP_Sales) AS StdDev_JP_Sales
    FROM
        vgsales
    GROUP BY
        Genre
)
SELECT
    vgsales.Name,
    vgsales.Genre,
    vgsales.NA_Sales,
    vgsales.EU_Sales,
    vgsales.JP_Sales
FROM
    vgsales
JOIN
    GenreStatistics ON vgsales.Genre = GenreStatistics.Genre
WHERE
    ABS((vgsales.NA_Sales - Avg_NA_Sales) / NULLIF(StdDev_NA_Sales, 0)) > 2.0
    OR ABS((vgsales.EU_Sales - Avg_EU_Sales) / NULLIF(StdDev_EU_Sales, 0)) > 2.0
    OR ABS((vgsales.JP_Sales - Avg_JP_Sales) / NULLIF(StdDev_JP_Sales, 0)) > 2.0;

--Can you analyze the dynamic market share of each gaming platform over the years, considering the changing landscape? 
--For this question, the Wii U will be focused on.
WITH PlatformMarketShare AS (
    SELECT
        TRY_CAST(Year AS INT) AS Year,  -- Use TRY_CAST to handle 'N/A'
        Platform,
        SUM(Global_Sales) AS PlatformSales,
        SUM(SUM(Global_Sales)) OVER (PARTITION BY TRY_CAST(Year AS INT)) AS TotalSalesPerYear
    FROM
        vgsales
    GROUP BY
        TRY_CAST(Year AS INT), Platform
)
SELECT
    Year,
    Platform,
    ROUND(PlatformSales, 2) AS PlatformSales,
    ROUND((PlatformSales / NULLIF(TotalSalesPerYear, 0)) * 100, 2) AS MarketSharePercentage -- Rounded to two decimal places
FROM
    PlatformMarketShare
WHERE
    Year > 2011 AND Year < 2017 --Release of the Wii U was 2012
ORDER BY
    Year, MarketSharePercentage DESC;
