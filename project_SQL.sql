create database energy;
use energy;

-- 1. country table
CREATE TABLE country (
    CID VARCHAR(10) PRIMARY KEY,
    Country VARCHAR(100) UNIQUE
);

SELECT * FROM COUNTRY;

-- 2. emission_3 table
CREATE TABLE emission_3 (
    country VARCHAR(100),
    energy_type VARCHAR(50),
    year INT,
    emission INT,
    per_capita_emission DOUBLE,
    FOREIGN KEY (country) REFERENCES country(Country)
);

SELECT * FROM EMISSION_3;


-- 3. population table
CREATE TABLE population (
    countries VARCHAR(100),
    year INT,
    Value DOUBLE,
    FOREIGN KEY (countries) REFERENCES country(Country)
);

SELECT * FROM POPULATION;

-- 4. production table
CREATE TABLE production (
    country VARCHAR(100),
    energy VARCHAR(50),
    year INT,
    production INT,
    FOREIGN KEY (country) REFERENCES country(Country)
);


SELECT * FROM PRODUCTION;

-- 5. gdp_3 table
CREATE TABLE gdp_3 (
    Country VARCHAR(100),
    year INT,
    Value DOUBLE,
    FOREIGN KEY (Country) REFERENCES country(Country)
);

SELECT * FROM GDP_3;

-- 6. consumption table
CREATE TABLE consumption (
    country VARCHAR(100),
    energy VARCHAR(50),
    year INT,
    consumption INT,
    FOREIGN KEY (country) REFERENCES country(Country)
);

SELECT * FROM CONSUMPTION;
select * from country;



--- Data Analysis Questions
--- General & Comparative Analysis


-- What is the total emission per country for the most recent year available?

SELECT 
    country,
    SUM(emission) AS total_emission,
    year
FROM emission_3
WHERE year = (SELECT MAX(year) FROM emission_3)
GROUP BY country, year;

--- What are the top 5 countries by GDP in the most recent year?


SELECT 
    Country, 
    Value AS GDP
FROM gdp_3
WHERE year = (SELECT MAX(year) FROM gdp_3)
ORDER BY GDP DESC
LIMIT 5;

--- Compare energy production and consumption by country and year.?


 -- 3.Compare energy production and consumption by country and year.


SELECT p.country AS country, SUM(p.production), SUM(c.consumption), p.year AS year
FROM production AS p 
LEFT JOIN consumption AS c
ON p.country = c.country
GROUP BY country, year;


--- 4. Which energy types contribute most to emissions across all countries?


SELECT energy_type, SUM(emission) AS total_emission
FROM emission_3
GROUP BY energy_type
ORDER BY total_emission DESC;

# Trend Analysis Over Time
-- 5. How have global emissions changed year over year?
SELECT year, SUM(emission) AS total_emission
FROM emission_3
GROUP BY year
ORDER BY year;

-- 6. What is the trend in GDP for each country over the given years?
SELECT Country, year, Value AS GDP
FROM gdp_3
ORDER BY Country, year;

-- 7. How has population growth affected total emissions in each country?
SELECT e.country, e.year, 
       SUM(e.emission) AS total_emission, 
       p.Value AS population,
       SUM(e.emission) / p.Value AS emission_per_capita
FROM emission_3 AS e
JOIN population AS p 
  ON e.country = p.countries AND e.year = p.year
GROUP BY e.country, e.year, p.Value
ORDER BY e.country, e.year;


-- 8. Has energy consumption increased or decreased over the years for major economies?
WITH top_gdp AS (
  SELECT Country
  FROM gdp_3
  WHERE year = (SELECT MAX(year) FROM gdp_3)
  ORDER BY Value DESC
  LIMIT 5
)
SELECT c.country, c.year, SUM(c.consumption) AS total_consumption
FROM consumption AS c
WHERE c.country IN (SELECT Country FROM top_gdp)
GROUP BY c.country, c.year
ORDER BY c.country, c.year;


-- 9. What is the average yearly change in emissions per capita for each country?
SELECT country, year, AVG(per_capita_emission) AS avg_yearly_change
FROM emission_3
GROUP BY country, year;


# Ratio & Per Capita Analysis
-- 10. What is the emission-to-GDP ratio for each country by year?
SELECT e.country, e.year, SUM(e.emission) / g.Value AS emission_to_gdp
FROM emission_3 AS e
JOIN gdp_3 AS g
  ON e.country = g.Country AND e.year = g.year
GROUP BY e.country, e.year, g.Value
ORDER BY e.country, e.year;


-- 11. What is the energy consumption per capita for each country over the last decade?
SELECT p.countries, SUM(c.consumption)/SUM(p.Value) AS energy_consumption_per_capita
FROM population AS p
JOIN consumption AS c
ON p.countries = c.country
GROUP BY p.countries;


-- 12. How does energy production per capita vary across countries?
SELECT p.country, p.year, SUM(p.production)/pop.Value AS production_per_capita
FROM production p
JOIN population pop 
  ON p.country = pop.countries AND p.year = pop.year
GROUP BY p.country, p.year, pop.Value
ORDER BY p.country, p.year;


-- 13. Which countries have the highest energy consumption relative to GDP?
SELECT c.country, c.year, SUM(c.consumption)/SUM(gd.Value) AS Energy_Consumption_to_GDPRatio 
FROM consumption AS c 
JOIN gdp_3 AS gd
ON c.country = gd.Country AND c.year = gd.year
GROUP BY c.country, c.year
ORDER BY Energy_Consumption_to_GDPRatio DESC
LIMIT 10;


-- 14. What is the correlation between GDP growth and energy production growth?
SELECT p.country, p.year, SUM(p.production) AS total_production, SUM(gd.Value) AS gdp
FROM production p
JOIN gdp_3 AS gd
ON p.country = gd.Country AND p.year = gd.year
GROUP BY p.country, p.year;


# Global Comparisons
-- 15. What are the top 10 countries by population and how do their emissions compare?
SELECT 
    p.countries AS country,
    MAX(p.value) AS population,
    SUM(e.emission) AS total_emission
FROM population p
JOIN emission_3 e 
    ON p.countries = e.country
GROUP BY p.countries
ORDER BY population DESC
LIMIT 10;


-- 16. What is the global share (%) of emissions by country?
WITH total AS (
  SELECT SUM(emission) AS total_emission
  FROM emission_3
)
SELECT country, SUM(emission) AS country_emission,
       (SUM(emission)/(SELECT total_emission FROM total))*100 AS share_percent
FROM emission_3
GROUP BY country
ORDER BY share_percent DESC;


-- 17. What is the global average GDP, emission, and population by year?
SELECT g.year,
       ROUND(AVG(g.Value),2) AS avg_gdp,
       ROUND(AVG(e.emission),2) AS avg_emission,
       ROUND(AVG(p.Value),2) AS avg_population 
FROM gdp_3 AS g
JOIN emission_3 AS e
  ON g.Country = e.country AND g.year = e.year
JOIN population AS p
  ON g.Country = p.countries AND g.year = p.year
GROUP BY g.year
ORDER BY g.year;








