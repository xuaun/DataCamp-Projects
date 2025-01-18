-- # Staffelter Hof Winery is Germany's oldest business, established in 862 under the Carolingian dynasty. It has continued to serve customers through dramatic changes in Europe, such as the Holy Roman Empire, the Ottoman Empire, and both world wars. What characteristics enable a business to stand the test of time?
-- # 
-- # To help answer this question, BusinessFinancing.co.uk researched the oldest company still in business in **almost** every country and compiled the results into several CSV files. This dataset has been cleaned.
-- # 
-- # Having useful information in different files is a common problem. While it's better to keep different types of data separate for data storage, you'll want all the data in one place for analysis. You'll use joining and data manipulation to work with this data and better understand the world's oldest businesses.
-- # 
-- # ## The Data
-- # `businesses` and `new_businesses`
-- # |Column|Description|
-- # |------|-----------|
-- # |`business`|Name of the business (varchar)|
-- # |`year_founded`|Year the business was founded (int)|
-- # |`category_code`|Code for the business category (varchar)|
-- # |`country_code`|ISO 3166-1 three-letter country code (char)|
-- # ---
-- # `countries`
-- # |Column|Description|
-- # |------|-----------|
-- # |`country_code`|ISO 3166-1 three-letter country code (varchar)|
-- # |`country`|Name of the country (varchar)|
-- # |`continent`|Name of the continent the country exists in (varchar)|
-- # ---
-- # `categories`
-- # |Column|Description|
-- # |------|-----------|
-- # |`category_code`|Code for the business category (varchar)|
-- # |`category`|Description of the business category (varchar)|

-- What is the oldest business on each continent?
WITH oldest AS (
	SELECT
		continent,
		MIN(year_founded) AS year_founded
	FROM countries
	INNER JOIN businesses
	USING(country_code)
	GROUP BY continent
)

SELECT 
	o.continent,
	country,
	business,
	o.year_founded
FROM (SELECT continent, country, business, year_founded FROM businesses INNER JOIN countries USING(country_code)) AS c
INNER JOIN oldest AS o
ON c.continent = o.continent AND c.year_founded = o.year_founded
ORDER BY year_founded;

-- How many countries per continent lack data on the oldest businesses
-- Does including the `new_businesses` data change this?
SELECT c.continent, COUNT(c.country_code) AS countries_without_businesses
FROM countries c
LEFT JOIN (
    SELECT * FROM businesses
    UNION ALL
    SELECT * FROM new_businesses
) b
ON c.country_code = b.country_code
WHERE b.business IS NULL
GROUP BY c.continent;

-- Which business categories are best suited to last over the course of centuries?
SELECT 
	co.continent,
	ca.category,
	MIN(b.year_founded) AS year_founded
FROM businesses AS b
INNER JOIN categories AS ca
USING(category_code)
INNER JOIN countries AS co
USING(country_code)
GROUP BY continent, category
ORDER BY continent ASC, category ASC;


