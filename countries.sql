## Question 1 1. What query would you run to get all the countries that speak Slovene? Your query should return the name of the country, language and language percentage. Your query should arrange the result by language percentage in descending order. 

SELECT countries.name, languages.language, languages.percentage
FROM languages
JOIN countries ON country_id = countries.id
WHERE languages.language = 'Slovene'
ORDER BY languages.percentage DESC;

SELECT *
FROM languages
WHERE language = 'Slovene';

## Question 2 What query would you run to display the total number of cities for each country? Your query should return the name of the country and the total number of cities. Your query should arrange the result by the number of cities in descending order.

SELECT countries.name, cities.country_code, COUNT(cities.name) as sum_cities
FROM countries
JOIN cities ON countries.id = cities.country_id
GROUP BY cities.country_code
ORDER BY sum_cities DESC;

SELECT country_code, COUNT(name) as sum_cities
FROM cities
GROUP BY country_code
ORDER BY sum_cities DESC;

### Question 3 What query would you run to get all the cities in Mexico with a population of greater than 500,000? Your query should arrange the result by population in descending order.

SELECT countries.name, cities.name, cities.population
FROM countries
JOIN cities ON countries.id = cities.country_id
WHERE countries.name = 'Mexico' AND cities.population > 500000
ORDER BY cities.population DESC;

#Question 4 What query would you run to get all languages in each country with a percentage greater than 89%? Your query should arrange the result by percentage in descending order.

SELECT countries.name, languages.language, languages.percentage
FROM countries
JOIN languages ON countries.id = languages.country_id
WHERE languages.percentage > 89 AND languages.language IS NOT NULL
ORDER BY languages.percentage DESC;

## Question 5 What query would you run to get all the countries with Surface Area below 501 and Population greater than 100,000?

SELECT name, surface_area, population
FROM countries
WHERE surface_area < 501 AND population > 100000;

## Question 6 What query would you run to get countries with only Constitutional Monarchy with a capital greater than 200 and a life expectancy greater than 75 years? 

SELECT name, government_form, capital, life_expectancy
FROM countries
WHERE government_form = 'Constitutional Monarchy' AND capital > 200 AND life_expectancy > 75;

## Question 7 What query would you run to get all the cities of Argentina inside the Buenos Aires district and have the population greater than 500, 000? The query should return the Country Name, City Name, District and Population.

SELECT countries.name, cities.name, cities.district, cities.population
FROM countries
JOIN cities ON countries.id = cities.country_id
WHERE cities.country_code = 'ARG' AND cities.district = 'Buenos Aires' AND cities.population > 500000;

## Question 8 What query would you run to summarize the number of countries in each region? The query should display the name of the region and the number of countries. Also, the query should arrange the result by the number of countries in descending order

SELECT region, COUNT(name) as count_region
FROM countries
GROUP BY region
ORDER BY count_region DESC;

